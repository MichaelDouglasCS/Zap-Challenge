//
//  FavoritesViewController.swift
//  Zap-Challenge
//
//  Created by Michael Douglas on 14/02/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

//*************************************************
// MARK: - Class -
//*************************************************

class FavoritesViewController: UIViewController {
    
    //*************************************************
    // MARK: - Outlets
    //*************************************************
    
    @IBOutlet weak var placeholderImage: UIImageView!
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    var viewModel: FavoritesViewModel!
    
    //*************************************************
    // MARK: - Lyfe Cicle
    //*************************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Change Status Bar Style
        UIApplication.shared.statusBarStyle = .lightContent
        // Navigation
        self.navigationItem.title = self.viewModel.headerTitle
        
        // Setup CollectionView
        self.collectionView.scrollsToTop = true
        self.collectionView.register(TopGameCollectionViewModel.cellNib,
                                     forCellWithReuseIdentifier: TopGameCollectionViewModel.reuseIdentifier)
        
        // Setup Placeholder
        self.placeholderImage.image = self.viewModel.placeholderImage
        self.placeholderLabel.text = self.viewModel.placeholderMessage
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadData()
    }
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let gameDetails = segue.destination as? GameDetailsViewController,
            let index = sender as? Int {
            gameDetails.viewModel = GameDetailsViewModel(provider: GameDetailsProvider(),
                                                         gameRank: self.viewModel.favoriteGames[index],
                                                         index: index)
            self.navigationItem.backBarButtonItem = UIBarButtonItem()
        }
    }
    
    //*************************************************
    // MARK: - Private Methods
    //*************************************************
    
    private func loadData() {
        self.viewModel.loadFavoriteGames()
        self.collectionView.reloadData()
        self.isPlaceholderVisible()
    }
    
    fileprivate func reloadData() {
        var indexPaths: [IndexPath] = []
        
        self.viewModel.favoriteGames.forEach({ (gameRank) in
            if let index = self.viewModel.favoriteGames.index(of: gameRank) {
                indexPaths.append(IndexPath(item: index, section: 0))
            }
        })
        
        self.collectionView.performBatchUpdates({
            self.collectionView.reloadItems(at: indexPaths)
        })
    }
    
    fileprivate func isPlaceholderVisible() {
        self.placeholderImage.isHidden = !self.viewModel.isShowPlaceholder
        self.placeholderLabel.isHidden = !self.viewModel.isShowPlaceholder
    }
}

//*************************************************
// MARK: - Extension - UICollectionViewDataSource
//*************************************************

extension FavoritesViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.viewModel.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellViewModel = self.viewModel.cellViewModel(at: indexPath)
        
        switch cellViewModel {
        case is TopGameCollectionViewModel:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopGameCollectionViewModel.reuseIdentifier,
                                                          for: indexPath) as! TopGameCollectionViewCell
            cell.viewModel = cellViewModel as! TopGameCollectionViewModel
            cell.delegate = self
            cell.setup()
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

//*************************************************
// MARK: - Extension - UICollectionViewDelegateFlowLayout
//*************************************************

extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return self.viewModel.insetForSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.viewModel.minimumLineSpacingForSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.viewModel.minimumInteritemSpacingForSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.viewModel.sizeForItem(fromView: self.view)
    }
}

//*************************************************
// MARK: - Extension - UICollectionViewDelegate
//*************************************************

extension FavoritesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showGameDetails", sender: indexPath.row)
    }
}

//*************************************************
// MARK: - Extension - TopGameCollectionViewCellDelegate
//*************************************************

extension FavoritesViewController: TopGameCollectionViewCellDelegate {
    
    func didTouchAddFavoriteGame(_ game: GameRank?) { }
    
    func didTouchRemoveFavoriteGame(_ game: GameRank?) {
        if let gameRank = game,
            let index = self.viewModel.favoriteGames.index(of: gameRank) {
            self.collectionView.performBatchUpdates({
                self.viewModel.removeFavoriteGame(game)
                self.collectionView.deleteItems(at: [IndexPath(item: index, section: 0)])
            }, completion: { (_) in
                self.reloadData()
            })
        } else {
            self.viewModel.removeFavoriteGame(game)
            self.collectionView.reloadSections([0])
            self.reloadData()
        }
        self.isPlaceholderVisible()
    }
}

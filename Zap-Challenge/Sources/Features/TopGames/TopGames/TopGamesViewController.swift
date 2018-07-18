//
//  TopGamesViewController.swift
//  Zap-Challenge
//
//  Created by Michael Douglas on 08/02/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

//*************************************************
// MARK: - Class -
//*************************************************

class TopGamesViewController: UIViewController {
    
    //*************************************************
    // MARK: - Outlets
    //*************************************************
    
    @IBOutlet weak var placeholderImage: UIImageView!
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    var viewModel: TopGamesViewModel!
    
    //*************************************************
    // MARK: - Private Properties
    //*************************************************
    
    private let refreshControl = UIRefreshControl()
    
    //*************************************************
    // MARK: - Lyfe Cicle
    //*************************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Change Status Bar Style
        UIApplication.shared.statusBarStyle = .lightContent
        
        // Navigation
        self.navigationItem.title = self.viewModel.headerTitle
        
        // Setup Refresh Control
        self.refreshControl.tintColor = UIColor.ZAP.purple
        self.refreshControl.addTarget(self, action: #selector(self.refreshData), for: .valueChanged)
        self.collectionView.register(LoadingFooterCollectionView.viewNib,
                                     forSupplementaryViewOfKind: UICollectionElementKindSectionFooter,
                                     withReuseIdentifier: LoadingFooterCollectionView.reuseIdentifier)
        
        // Setup SearchBar
        self.searchBar.placeholder = self.viewModel.searchBarPlaceholder
        
        // Setup CollectionView
        self.collectionView.delaysContentTouches = false
        self.collectionView.scrollsToTop = true
        self.collectionView.refreshControl = self.refreshControl
        self.collectionView.register(TopGameCollectionViewModel.cellNib,
                                     forCellWithReuseIdentifier: TopGameCollectionViewModel.reuseIdentifier)
        
        // Setup Placeholder
        self.placeholderImage.image = self.viewModel.placeholderImage
        self.placeholderLabel.text = self.viewModel.placeholderMessage
        
        // Load Data
        self.collectionView.showLoading(isShow: true, isLarge: true, color: UIColor.ZAP.purple)
        self.loadData {
            self.collectionView.showLoading(isShow: false)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewModel.verifyFavoriteGames()
        
        var indexPaths: [IndexPath] = []
        
        self.viewModel.gamesRank.forEach { (gameRank) in
            if let index = self.viewModel.gamesRank.index(of: gameRank) {
                indexPaths.append(IndexPath(item: index, section: 0))
            }
        }
        
        self.collectionView.performBatchUpdates({
            self.collectionView.reloadItems(at: indexPaths)
        })
    }
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let gameDetails = segue.destination as? GameDetailsViewController,
            let index = sender as? Int {
            gameDetails.viewModel = GameDetailsViewModel(provider: GameDetailsProvider(),
                                                         gameRank: self.viewModel.gamesRank[index],
                                                         index: index)
            self.navigationItem.backBarButtonItem = UIBarButtonItem()
            self.view.endEditing(true)
        }
    }
    
    //*************************************************
    // MARK: - Private Methods
    //*************************************************
    
    @objc private func refreshData() {
        self.viewModel.isPullToRefresh = true
        self.loadData {
            self.viewModel.isPullToRefresh = false
            self.refreshControl.endRefreshing()
            self.searchBar.text?.removeAll()
            self.viewModel.isSearch = self.searchBar.text?.isEmpty == false
        }
    }
    
    private func loadData(completion: @escaping () -> Void) {
        self.viewModel.isLoading = true
        self.viewModel.loadTopGames { (isSuccess, localizedError) in
            self.viewModel.isLoading = false
            self.isPlaceholderVisible()
            
            if isSuccess {
                if self.viewModel.gamesRank.count > self.collectionView.numberOfItems(inSection: 0) && !self.viewModel.isSearch {
                    // Insert New
                    var indexPaths: [IndexPath] = []
                    
                    for (index, gameRank) in self.viewModel.gamesRank.enumerated() where gameRank.isNew {
                        indexPaths.append(IndexPath(item: index, section: 0))
                    }
                    
                    self.collectionView.performBatchUpdates({
                        self.collectionView.insertItems(at: indexPaths)
                    })
                } else {
                    // Reload All
                    self.collectionView.reloadSections([0])
                }
            } else {
                self.showInfoAlert(title: String.ZAP.sorry, message: localizedError)
            }
            completion()
        }
    }
    
    fileprivate func isPlaceholderVisible() {
        self.placeholderImage.isHidden = !self.viewModel.isShowPlaceholder
        self.placeholderLabel.isHidden = !self.viewModel.isShowPlaceholder
    }
}

//*************************************************
// MARK: - Extension - UICollectionViewDataSource
//*************************************************

extension TopGamesViewController: UICollectionViewDataSource {
    
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
            self.viewModel.gamesRank[indexPath.row].isNew = false
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastRowItem = self.collectionView.numberOfItems(inSection: indexPath.section) - 1
        
        if lastRowItem == indexPath.row && self.viewModel.isLoadingFooterVisible() {
            self.viewModel.footerView?.startAnimate()
            self.loadData {
                self.viewModel.footerView?.stopAnimate()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return self.viewModel.collectionView(self.collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
    }
}

//*************************************************
// MARK: - Extension - UICollectionViewDelegateFlowLayout
//*************************************************

extension TopGamesViewController: UICollectionViewDelegateFlowLayout {
    
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return self.viewModel.referenceSizeForFooter(fromView: self.view)
    }
}

//*************************************************
// MARK: - Extension - UICollectionViewDelegate
//*************************************************

extension TopGamesViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            self.performSegue(withIdentifier: "showGameDetails", sender: indexPath.row)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.2, options: .allowUserInteraction, animations: {
                cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            })
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            UIView.animate(withDuration: 0.4, delay: 0.05, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.2, options: .allowUserInteraction, animations: {
                cell.transform = .identity
            })
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}

//*************************************************
// MARK: - Extension - TopGameCollectionViewCellDelegate
//*************************************************

extension TopGamesViewController: TopGameCollectionViewCellDelegate {
    
    func didTouchAddFavoriteGame(_ game: GameRank?) {
        self.viewModel.addFavoriteGame(game)
    }
    
    func didTouchRemoveFavoriteGame(_ game: GameRank?) {
        self.viewModel.removeFavoriteGame(game)
    }
}

//*************************************************
// MARK: - Extension - UISearchBarDelegate
//*************************************************

extension TopGamesViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.isSearch = !searchText.isEmpty
        self.viewModel.searchGames(for: searchText)
        self.viewModel.verifyFavoriteGames()
        self.collectionView.reloadData()
        self.isPlaceholderVisible()
    }
}


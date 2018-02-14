//
//  FavoritesViewController.swift
//  Zap-Challenge
//
//  Created by Michael Douglas on 14/02/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

//**********************************************************************************************************
//
// MARK: - Class -
//
//**********************************************************************************************************

class FavoritesViewController: UIViewController {
  
  //*************************************************
  // MARK: - Properties
  //*************************************************
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  var viewModel: FavoritesViewModel!
  
  //*************************************************
  // MARK: - Lyfe Cicle
  //*************************************************
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //Change Status Bar Style
    UIApplication.shared.statusBarStyle = .lightContent
    //Navigation
    self.navigationItem.title = self.viewModel.headerTitle
    
    //Configure CollectionView
    self.collectionView.scrollsToTop = true
    self.collectionView.register(TopGameCollectionViewModel.cellNib,
                                 forCellWithReuseIdentifier: TopGameCollectionViewModel.reuseIdentifier)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.loadData()
  }
  
  //*************************************************
  // MARK: - Private Methods
  //*************************************************
  
  private func loadData() {
    self.viewModel.loadFavoriteGames()
    self.collectionView.reloadData()
  }
}

//**********************************************************************************************************
//
// MARK: - Extension - UICollectionViewDataSource
//
//**********************************************************************************************************

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

//**********************************************************************************************************
//
// MARK: - Extension - UICollectionViewDelegateFlowLayout
//
//**********************************************************************************************************

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

//**********************************************************************************************************
//
// MARK: - Extension - TopGameCollectionViewCellDelegate
//
//**********************************************************************************************************


extension FavoritesViewController: TopGameCollectionViewCellDelegate {
  
  func didTouchAddFavoriteGame(_ game: GameRank?) { }
  
  func didTouchRemoveFavoriteGame(_ game: GameRank?) {
    if let gameRank = game,
      let index = self.viewModel.favoriteGames.index(of: gameRank) {
      self.collectionView.performBatchUpdates({
        self.viewModel.removeFavoriteGame(game)
        self.collectionView.deleteItems(at: [IndexPath(item: index, section: 0)])
      })
    } else {
      self.viewModel.removeFavoriteGame(game)
      self.collectionView.reloadSections([0])
    }
  }
}

//**********************************************************************************************************
//
// MARK: - Extension - UICollectionViewDelegate
//
//**********************************************************************************************************

extension FavoritesViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print("SELECIONOU: \(self.viewModel.favoriteGames[indexPath.row].game?.name ?? "")")
  }
}
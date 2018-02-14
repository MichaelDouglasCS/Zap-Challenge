//
//  TopGamesViewController.swift
//  Zap-Challenge
//
//  Created by Michael Douglas on 08/02/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

//**********************************************************************************************************
//
// MARK: - Class -
//
//**********************************************************************************************************

class TopGamesViewController: UIViewController {

  //*************************************************
  // MARK: - Properties
  //*************************************************
  
  @IBOutlet weak var placeholderImage: UIImageView!
  @IBOutlet weak var placeholderLabel: UILabel!
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var collectionView: UICollectionView!
  
  private let refreshControl = UIRefreshControl()
  
  var viewModel: TopGamesViewModel!
  
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
    self.collectionView.register(LoadingFooterCollectionViewModel.viewNib,
                                 forSupplementaryViewOfKind: UICollectionElementKindSectionFooter,
                                 withReuseIdentifier: LoadingFooterCollectionViewModel.reuseIdentifier)
    
    // Setup CollectionView
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
  // MARK: - Private Methods
  //*************************************************
  
  @objc private func refreshData() {
    self.viewModel.isPullToRefresh = true
    self.loadData {
      self.viewModel.isPullToRefresh = false
      self.refreshControl.endRefreshing()
    }
  }
  
  private func loadData(completion: @escaping () -> ()) {
    self.viewModel.isLoading = true
    self.viewModel.loadTopGames { (isSuccess, localizedError) in
      self.viewModel.isLoading = false
      self.isPlaceholderVisible()
      completion()
      
      if isSuccess {
        
        if self.viewModel.gamesRank.count > self.collectionView.numberOfItems(inSection: 0) {
          // Insert New
          var indexPaths: [IndexPath] = []
          
          for (index, gameRank) in self.viewModel.gamesRank.enumerated() {
            if gameRank.isNew {
              indexPaths.append(IndexPath(item: index, section: 0))
            }
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
    }
  }
  
  fileprivate func isPlaceholderVisible() {
    self.placeholderImage.isHidden = !self.viewModel.isShowPlaceholder
    self.placeholderLabel.isHidden = !self.viewModel.isShowPlaceholder
  }
}

//**********************************************************************************************************
//
// MARK: - Extension - UICollectionViewDataSource
//
//**********************************************************************************************************

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
    
    if lastRowItem == indexPath.row && !self.viewModel.isLastGame() {
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

//**********************************************************************************************************
//
// MARK: - Extension - UICollectionViewDelegateFlowLayout
//
//**********************************************************************************************************

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

//**********************************************************************************************************
//
// MARK: - Extension - TopGameCollectionViewCellDelegate
//
//**********************************************************************************************************


extension TopGamesViewController: TopGameCollectionViewCellDelegate {
  
  func didTouchAddFavoriteGame(_ game: GameRank?) {
    self.viewModel.addFavoriteGame(game)
  }
  
  func didTouchRemoveFavoriteGame(_ game: GameRank?) {
    self.viewModel.removeFavoriteGame(game)
  }
}

//**********************************************************************************************************
//
// MARK: - Extension - UICollectionViewDelegate
//
//**********************************************************************************************************

extension TopGamesViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    self.performSegue(withIdentifier: "showGameDetails", sender: nil)
  }
}

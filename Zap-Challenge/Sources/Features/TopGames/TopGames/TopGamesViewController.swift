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
  
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var collectionView: UICollectionView!
  
  private let refreshControl = UIRefreshControl()
  
  var viewModel: TopGamesViewModel!
  
  //*************************************************
  // MARK: - Lyfe Cicle
  //*************************************************
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupNavigationBar()
    self.setupCollectionView()
    self.fetchData()
  }
  
  //*************************************************
  // MARK: - Private Methods
  //*************************************************

  private func setupNavigationBar() {
    //Change Status Bar Style
    UIApplication.shared.statusBarStyle = .lightContent
    //Navigation
    self.navigationItem.title = self.viewModel.headerTitle
  }
  
  private func setupCollectionView() {
    // Configure Refresh Control
    self.refreshControl.tintColor = UIColor.ZAP.purple
    self.refreshControl.addTarget(self, action: #selector(self.refreshData), for: .valueChanged)
    
    //Configure CollectionView
    self.collectionView.scrollsToTop = true
    self.collectionView.allowsSelection = true
    self.collectionView.allowsMultipleSelection = false
    self.collectionView.refreshControl = self.refreshControl
  }
  
  private func fetchData() {
    self.collectionView.showLoading(isShow: true, isLarge: true, color: UIColor.ZAP.purple)
    self.loadData {
      self.collectionView.showLoading(isShow: false)
    }
  }
  
  @objc private func refreshData() {
    self.loadData {
      self.refreshControl.endRefreshing()
    }
  }
  
  private func loadData(completion: @escaping ()->()) {
    self.viewModel.loadTopGames { (isSuccess, localizedError) in
      completion()
      if isSuccess {
        self.collectionView.reloadSections([0])
      } else {
        self.showInfoAlert(title: String.ZAP.sorry, message: localizedError)
      }
    }
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
    return self.viewModel.numberOfItems(inSection: section)
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cellViewModel = self.viewModel.cellViewModel(at: indexPath)
    
    switch cellViewModel {
    case is TopGameCollectionViewModel:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopGameCollectionViewModel.cellNibName,
                                                    for: indexPath) as! TopGameCollectionViewCell
      cell.viewModel = cellViewModel as! TopGameCollectionViewModel
      cell.setup()
      
      return cell
    default:
      return UICollectionViewCell()
    }
  }
}

//**********************************************************************************************************
//
// MARK: - Extension - UICollectionViewDelegate
//
//**********************************************************************************************************

extension TopGamesViewController: UICollectionViewDelegate {
  
}

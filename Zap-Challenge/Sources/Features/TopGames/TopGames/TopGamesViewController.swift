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
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  var viewModel: TopGamesViewModel!
  
  //*************************************************
  // MARK: - Lyfe Cicle
  //*************************************************
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupNavigationBar()
    self.setupCollectionView()
    self.loadData()
  }
  
  //*************************************************
  // MARK: - Private Methods
  //*************************************************

  private func setupNavigationBar() {
    UIApplication.shared.statusBarStyle = .lightContent
    self.navigationItem.title = self.viewModel.headerTitle
  }
  
  private func setupCollectionView() {
    self.collectionView.scrollsToTop = true
    self.collectionView.allowsSelection = true
    self.collectionView.allowsMultipleSelection = false
  }
  
  private func loadData() {
    self.viewModel.loadTopGames { (isSuccess, localizedError) in
      
      if isSuccess {
        self.collectionView.reloadData()
      } else {
        self.showInfoAlert(title: "Error", message: localizedError)
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
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Teste", for: indexPath)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      viewForSupplementaryElementOfKind kind: String,
                      at indexPath: IndexPath) -> UICollectionReusableView {
    
    if kind == UICollectionElementKindSectionHeader {
      let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SearchBarView", for: indexPath)
      return view
    }
    return UICollectionReusableView()
  }
}

//**********************************************************************************************************
//
// MARK: - Extension - UICollectionViewDelegate
//
//**********************************************************************************************************

extension TopGamesViewController: UICollectionViewDelegate {
  
}

//**********************************************************************************************************
//
// MARK: - Extension - UISearchBarDelegate
//
//**********************************************************************************************************

extension TopGamesViewController: UISearchBarDelegate {
  
}

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
    self.collectionView.register(LoadingFooterCollectionViewModel.viewNib,
                                 forSupplementaryViewOfKind: UICollectionElementKindSectionFooter,
                                 withReuseIdentifier: LoadingFooterCollectionViewModel.reuseIdentifier)
    
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
  
  private func loadData(completion: @escaping () -> ()) {
    self.viewModel.isLoading = true
    self.viewModel.loadTopGames { (isSuccess, localizedError) in
      self.viewModel.isLoading = false
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
    return self.viewModel.numberOfItems()
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
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    let lastRowItem = self.collectionView.numberOfItems(inSection: indexPath.section) - 1
    
    if lastRowItem == indexPath.row {
      self.viewModel.footerView?.startAnimate()
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let view = self.viewModel.collectionView(self.collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
    return view
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
// MARK: - Extension - UICollectionViewDelegate
//
//**********************************************************************************************************

extension TopGamesViewController: UICollectionViewDelegate {
  
  
  
  
}

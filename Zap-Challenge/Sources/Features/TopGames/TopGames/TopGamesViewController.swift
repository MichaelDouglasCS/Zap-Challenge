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
  
  var viewModel: TopGamesViewModel!
  
  //*************************************************
  // MARK: - Lyfe Cicle
  //*************************************************
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupNavigationBar()
    self.loadData()
  }
  
  //*************************************************
  // MARK: - Private Methods
  //*************************************************

  private func setupNavigationBar() {
    UIApplication.shared.statusBarStyle = .lightContent
    self.navigationItem.title = self.viewModel.headerTitle
  }
  
  private func loadData() {
    self.viewModel.loadTopGames { (isSuccess, localizedError) in
      
      if isSuccess {
        
      } else {
        self.showInfoAlert(title: "Error", message: localizedError)
      }
    }
  }
  
  //*************************************************
  // MARK: - Exposed Methods
  //*************************************************

}

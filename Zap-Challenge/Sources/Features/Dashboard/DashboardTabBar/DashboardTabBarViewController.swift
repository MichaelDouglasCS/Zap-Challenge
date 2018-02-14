//
//  DashboardTabBarViewController.swift
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

class DashboardTabBarViewController: UITabBarController {

  //**************************************************
  // MARK: - Life Cycle
  //**************************************************
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.injectViewModels()
  }
  
  //*************************************************
  // MARK: - Private Methods
  //*************************************************
  
  private func injectViewModels() {
    self.viewControllers?.forEach({ (navigationViewController) in
      let firstViewController = (navigationViewController as? UINavigationController)?.viewControllers.first
      
      if let topGamesViewController = firstViewController as? TopGamesViewController {
        topGamesViewController.viewModel = TopGamesViewModel(provider: TopGamesProvider())
        navigationViewController.tabBarItem.title = String.ZAP.topGames
      } else if let favoritesViewController = firstViewController as? FavoritesViewController {
        favoritesViewController.viewModel = FavoritesViewModel(provider: FavoritesProvider())
        navigationViewController.tabBarItem.title = String.ZAP.favorites
      }
    })
  }
}

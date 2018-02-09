//
//  TopGamesViewModel.swift
//  Zap-Challenge
//
//  Created by Michael Douglas on 08/02/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

public class TopGamesViewModel: NSObject {
  
  //*************************************************
  // MARK: - Properties
  //*************************************************
  
  public var provider: TopGamesProvider
  
  public let headerTitle: String = String.ZAP.topGames
  public var games: [GameRank] = []
  
  //*************************************************
  // MARK: - Initializers
  //*************************************************
  
  init(provider: TopGamesProvider) {
    self.provider = provider
  }

  //*************************************************
  // MARK: - Exposed Methods
  //*************************************************
  
  public func loadTopGames(completion: @escaping (_ isSuccess: Bool, _ localizedError: String) -> Void) {
    self.provider.loadTopGames(with: 20, from: 0) { (topGames, error) in
      if let topGames = topGames {
        //Sorted by viewers
        self.games = topGames.sorted(by: { $0.viewers ?? 0 > $1.viewers ?? 0 })
      }
      completion(topGames != nil, error ?? "")
    }
  }
  
  public func numberOfSections() -> Int {
    return 1
  }
  
  public func numberOfItems(inSection section: Int) -> Int {
    switch section {
    case 0:
      return self.games.count
    default:
      return 0
    }
  }
  
  public func cellViewModel(at indexPath: IndexPath) -> Any {
    return 0
  }
}

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
  public let headerTitle: String = String.Local.topGames
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
        self.games = topGames
      }
      completion(topGames != nil, error ?? "")
    }
  }
}

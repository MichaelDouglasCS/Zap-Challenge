//
//  TopGamesProvider.swift
//  Zap-Challenge
//
//  Created by Michael Douglas on 08/02/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import Foundation
import SwiftyJSON

//**********************************************************************************************************
//
// MARK: - Class -
//
//**********************************************************************************************************

public class TopGamesProvider: NSObject {
 
  //*************************************************
  // MARK: - Exposed Methods
  //*************************************************
  
  public func loadTopGames(with limit: Int,
                           from offset: Int,
                           completion: @escaping (_ topGames: [GameRank]?, _ localizedError: String?) -> Void) {
    ServerRequest.Games.top(with: limit, from: offset).execute { (json, response) in
      
      switch response {
      case .success:
        var topGames: [GameRank] = []
        
        json["top"].arrayValue.forEach({ json in
          if let gameRank = GameRank(JSON: json.dictionaryObject ?? [:]) {
            topGames.append(gameRank)
          }
        })
        
        completion(topGames, nil)
      case .error:
        completion(nil, response.localizedError)
      }
    }
  }
}

//
//  TopGamesProvider.swift
//  Zap-Challenge
//
//  Created by Michael Douglas on 08/02/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import Foundation
import SwiftyJSON

//*************************************************
// MARK: - Class -
//*************************************************

public class TopGamesProvider: NSObject {
    
    //*************************************************
    // MARK: - Exposed Methods
    //*************************************************
    
    // Load Data
    public func loadTopGames(with limit: Int,
                             from offset: Int,
                             completion: @escaping (_ topGames: [GameRank]?, _ localizedError: String?) -> Void) {
        ServerRequest.Games.top(with: limit, from: offset).execute { (json, response) in
            switch response {
            case .success:
                var topGames: [GameRank] = []
                
                if let total = json["_total"].int {
                    self.saveTopGamesTotal(total)
                }
                
                json["top"].arrayValue.forEach({ json in
                    if let gameRank = GameRank(JSON: json.dictionaryObject ?? [:]) {
                        topGames.append(gameRank)
                    }
                })
                
                self.verifyFavoriteGames(topGames)
                completion(topGames, nil)
            case .error:
                completion(nil, response.localizedError)
            }
        }
    }
    
    // Total of Top Games
    public func saveTopGamesTotal(_ total: Int) {
        KeychainService.shared.setValue(total.toString(), forKey: "TopGamesTotal")
    }
    
    public func getTopGamesTotal() -> Int {
        return KeychainService.shared.getValue(forKey: "TopGamesTotal")?.toInt() ?? 0
    }
    
    // Favorite Games
    public func addFavoriteGame(_ gameRank: GameRank) {
        _ = gameRank.toNSManagedObject()
        PersistenceService.shared.saveContext()
    }
    
    public func removeFavoriteGame(_ gameRank: GameRank) {
        do {
            if let games = try PersistenceService.shared.context.fetch(GameRankMO.fetchRequest()) as? [GameRankMO] {
                games.forEach({
                    if $0.game?.id == Int32(gameRank.game?.id ?? 0) {
                        PersistenceService.shared.context.delete($0)
                    }
                })
            }
        } catch { }
    }
    
    public func verifyFavoriteGames(_ gamesRank: [GameRank]) {
        do {
            if let persistedGames = try PersistenceService.shared.context.fetch(GameRankMO.fetchRequest()) as? [GameRankMO] {
                gamesRank.forEach({ (gameRank) in
                    if persistedGames.contains(where: { $0.game?.id == Int32(gameRank.game?.id ?? 0) }) {
                        gameRank.isFavorite = true
                    } else {
                        gameRank.isFavorite = false
                    }
                })
            }
        } catch { }
    }
}

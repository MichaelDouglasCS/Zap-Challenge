//
//  GameDetailsProvider.swift
//  Zap-Challenge
//
//  Created by Michael Douglas on 14/02/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import Foundation

//*************************************************
// MARK: - Class -
//*************************************************

public class GameDetailsProvider: NSObject {
    
    //*************************************************
    // MARK: - Exposed Methods
    //*************************************************
    
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
}

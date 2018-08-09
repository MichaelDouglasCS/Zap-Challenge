//
//  FavoritesProvider.swift
//  Zap-Challenge
//
//  Created by Michael Douglas on 13/02/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import Foundation

//*************************************************
// MARK: - Class -
//*************************************************

public class FavoritesProvider: NSObject {
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    public func loadFavoriteGames() -> [GameRank] {
        var favorites: [GameRank] = []
        
        do {
            if let favoriteGames = try PersistenceService.shared.context.fetch(GameRankMO.fetchRequest()) as? [GameRankMO] {
                favoriteGames.forEach({ (gameRankMO) in
                    if gameRankMO.isFavorite {
                        favorites.append(GameRank(NSManagedObject: gameRankMO))
                    }
                })
            }
        } catch { }
        
        return favorites
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

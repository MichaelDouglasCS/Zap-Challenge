//
//  GameRank.swift
//  Zap-Challenge
//
//  Created by Michael Douglas on 08/02/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import Foundation
import ObjectMapper
import CoreData

//*************************************************
// MARK: - Class -
//*************************************************

public class GameRank: Mappable, PersistenceServiceProtocol {
    
    //*************************************************
    // MARK: - Properties
    //*************************************************
    
    public var game: Game?
    public var viewers: Int?
    public var channels: Int?
    public var isNew: Bool = true
    public var isFavorite: Bool = false
    
    //*************************************************
    // MARK: - Initializers
    //*************************************************
    
    public required init() { }
    
    public required init?(map: Map) { }
    
    public required convenience init(NSManagedObject object: NSManagedObject?) {
        self.init()
        
        if let gameRankMO = object as? GameRankMO {
            self.game = Game(NSManagedObject: gameRankMO.game)
            self.viewers = Int(gameRankMO.viewers)
            self.channels = Int(gameRankMO.channels)
            self.isNew = gameRankMO.isNew
            self.isFavorite = gameRankMO.isFavorite
        }
    }
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    public func mapping(map: Map) {
        self.game     <- map["game"]
        self.viewers  <- map["viewers"]
        self.channels <- map["channels"]
    }
    
    public func toNSManagedObject() -> NSManagedObject {
        let gameRankMO = GameRankMO(context: PersistenceService.shared.container.viewContext)
        
        gameRankMO.game = self.game?.toNSManagedObject() as? GameMO
        gameRankMO.viewers = Int32(self.viewers ?? 0)
        gameRankMO.channels = Int32(self.channels ?? 0)
        gameRankMO.isNew = self.isNew
        gameRankMO.isFavorite = self.isFavorite
        
        return gameRankMO
    }
}

//*************************************************
// MARK: - Extension - Equatable
//*************************************************

extension GameRank: Equatable {
    
    public static func == (lhs: GameRank, rhs: GameRank) -> Bool {
        return lhs.game?.id == rhs.game?.id
    }
}

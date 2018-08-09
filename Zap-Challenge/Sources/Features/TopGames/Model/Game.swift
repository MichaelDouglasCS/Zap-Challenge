//
//  Game.swift
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

public class Game: Mappable, PersistenceServiceProtocol {
    
    //*************************************************
    // MARK: - Properties
    //*************************************************
    
    public var id: Int?
    public var name: String?
    public var localizedName: String?
    public var popularity: Int?
    public var box: Media?
    public var logo: Media?
    public var giantbombID: Int?
    public var locale: String?
    
    //*************************************************
    // MARK: - Initializers
    //*************************************************
    
    public required init() { }
    
    public required init?(map: Map) { }
    
    public required convenience init(NSManagedObject object: NSManagedObject?) {
        self.init()
        
        if let gameMO = object as? GameMO {
            self.id = Int(gameMO.id)
            self.name = gameMO.name
            self.localizedName = gameMO.localizedName
            self.popularity = Int(gameMO.popularity)
            self.box = Media(NSManagedObject: gameMO.box)
            self.logo = Media(NSManagedObject: gameMO.logo)
            self.giantbombID = Int(gameMO.giantbombID)
            self.locale = gameMO.locale
        }
    }
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    public func mapping(map: Map) {
        self.id            <- map["_id"]
        self.name          <- map["name"]
        self.localizedName <- map["localized_name"]
        self.popularity    <- map["popularity"]
        self.box           <- map["box"]
        self.logo          <- map["logo"]
        self.giantbombID   <- map["giantbomb_id"]
        self.locale        <- map["locale"]
    }
    
    public func toNSManagedObject() -> NSManagedObject {
        let gameMO = GameMO(context: PersistenceService.shared.container.viewContext)
        
        gameMO.id = Int32(self.id ?? 0)
        gameMO.name = self.name
        gameMO.localizedName = self.localizedName
        gameMO.popularity = Int32(self.popularity ?? 0)
        gameMO.box = self.box?.toNSManagedObject() as? MediaMO
        gameMO.logo = self.logo?.toNSManagedObject() as? MediaMO
        gameMO.giantbombID = Int32(self.giantbombID ?? 0)
        gameMO.locale = self.locale
        
        return gameMO
    }
}

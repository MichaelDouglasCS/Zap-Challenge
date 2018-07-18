//
//  Media.swift
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

public class Media: Mappable, PersistenceServiceProtocol {
    
    //*************************************************
    // MARK: - Properties
    //*************************************************
    
    public var large: String?
    public var medium: String?
    public var small: String?
    public var template: String?
    
    //*************************************************
    // MARK: - Initializers
    //*************************************************
    
    public required init() { }
    
    public required init?(map: Map) { }
    
    public required convenience init(NSManagedObject object: NSManagedObject?) {
        self.init()
        
        if let mediaMO = object as? MediaMO {
            self.large = mediaMO.large
            self.medium = mediaMO.medium
            self.small = mediaMO.small
            self.template = mediaMO.template
        }
    }
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    public func mapping(map: Map) {
        self.large    <- map["large"]
        self.medium   <- map["medium"]
        self.small    <- map["small"]
        self.template <- map["template"]
    }
    
    public func toNSManagedObject() -> NSManagedObject {
        let mediaMO = MediaMO(context: PersistenceService.shared.container.viewContext)
        
        mediaMO.large = self.large
        mediaMO.medium = self.medium
        mediaMO.small = self.small
        mediaMO.template = self.template
        
        return mediaMO
    }
}

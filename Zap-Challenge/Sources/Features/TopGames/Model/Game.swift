//
//  Game.swift
//  Zap-Challenge
//
//  Created by Michael Douglas on 08/02/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import Foundation
import ObjectMapper

//**********************************************************************************************************
//
// MARK: - Class -
//
//**********************************************************************************************************

public class Game: Mappable {
  
  //**************************************************
  // MARK: - Properties
  //**************************************************
  
  public var id: Int?
  public var name: String?
  public var localizedName: String?
  public var popularity: Int?
  public var box: Media?
  public var logo: Media?
  public var giantbombID: Int?
  public var locale: String?
  
  //**************************************************
  // MARK: - Initializers
  //**************************************************
  
  public required init() { }
  
  public required init?(map: Map) { }
  
  //**************************************************
  // MARK: - Exposed Methods
  //**************************************************
  
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
}

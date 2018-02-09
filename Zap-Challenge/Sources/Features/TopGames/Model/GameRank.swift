//
//  GameRank.swift
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

public class GameRank: Mappable {
  
  //**************************************************
  // MARK: - Properties
  //**************************************************
  
  public var game: Game?
  public var viewers: Int?
  public var channels: Int?
  
  //**************************************************
  // MARK: - Initializers
  //**************************************************
  
  public required init() { }
  
  public required init?(map: Map) { }
  
  //**************************************************
  // MARK: - Exposed Methods
  //**************************************************
  
  public func mapping(map: Map) {
    self.game     <- map["game"]
    self.viewers  <- map["viewers"]
    self.channels <- map["channels"]
  }
}

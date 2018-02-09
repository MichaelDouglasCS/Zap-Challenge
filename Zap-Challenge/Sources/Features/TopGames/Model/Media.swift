//
//  Media.swift
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

public class Media: Mappable {
  
  //**************************************************
  // MARK: - Properties
  //**************************************************
  
  public var large: String?
  public var medium: String?
  public var small: String?
  public var template: String?
  
  //**************************************************
  // MARK: - Initializers
  //**************************************************
  
  public required init() { }
  
  public required init?(map: Map) { }
  
  //**************************************************
  // MARK: - Exposed Methods
  //**************************************************
  
  public func mapping(map: Map) {
    self.large    <- map["large"]
    self.medium   <- map["medium"]
    self.small    <- map["small"]
    self.template <- map["template"]
  }
}

//
//  Int+Utils.swift
//  Zap-Challenge
//
//  Created by Michael Douglas on 13/02/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import Foundation

//**********************************************************************************************************
//
// MARK: - Extension - Int
//
//**********************************************************************************************************

extension Int {
  
  //*************************************************
  // MARK: - Exposed Methods
  //*************************************************
  
  public func toString() -> String {
    return String(self)
  }
  
  func toDecimalFormat() -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = NumberFormatter.Style.decimal
    return numberFormatter.string(from: NSNumber(value: self)) ?? "0"
  }
}

//
//  String+Localized.swift
//  Zap-Challenge
//
//  Created by Michael Douglas on 07/02/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

//**********************************************************************************************************
//
// MARK: - Extension - String ZAP
//
//**********************************************************************************************************

extension String {
	
	struct ZAP {
    
		//*************************
		// Top Games
		//*************************
		static var topGames: String { return "ST_TOPGAMES".localized }
    static var emptyTopGames: String { return "ST_EMPTY_TOPGAMES".localized }
    
    //*************************
    // Favorite Games
    //*************************
    static var favorites: String { return "ST_FAVORITES".localized }
    static var noFavorites: String { return "ST_NO_FAVORITE".localized }
    
    //*************************
    // Game Details
    //*************************
    static var viewers: String { return "ST_VIEWERS".localized }
    static var gameDetails: String { return "ST_GAME_DETAILS".localized }
    
    //*************************
    // Alerts
    //*************************
    static var ok: String { return "ST_OK".localized }
    static var sorry: String { return "ST_SORRY".localized }
    static var noConnection: String { return "ST_NO_CONECTION".localized }
	}
}

//**********************************************************************************************************
//
// MARK: - Extension - String Localized
//
//**********************************************************************************************************

extension String {
	
//**************************************************
// MARK: - Exposed Methods
//**************************************************
	
	var localized: String {
		return NSLocalizedString(self, comment: self)
	}
  
  public func toInt() -> Int {
    return Int(self) ?? 0
  }
  
  func nsRange(from range: Range<Index>) -> NSRange {
    return NSRange(range, in: self)
  }
}

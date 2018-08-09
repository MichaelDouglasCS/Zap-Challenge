//
//  UIImage+Utils.swift
//  Zap-Challenge
//
//  Created by Michael Douglas on 11/02/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

//*************************************************
// MARK: - Extension - UIImage
//*************************************************

extension UIImage {
    
    struct ZAP {
        
        //*************************
        // Top Games
        //*************************
        static var joystickPlaceholder: UIImage { return UIImage(named: "icn_joystick_placeholder")! }
        static var emptyTopGamesPlaceholder: UIImage { return UIImage(named: "icn_sad")! }
        
        //*************************
        // Favorite Games
        //*************************
        static var favoritesPlaceholder: UIImage { return UIImage(named: "icn_favorites_placeholder")! }
        
        //*************************
        // Game Details
        //*************************
        static var favoritesSelected: UIImage { return UIImage(named: "btn_favorites_bordered")! }
        static var favoritesUnselected: UIImage { return UIImage(named: "btn_favorites")! }
    }
}

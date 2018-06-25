//
//  UIColor+StyleKit.swift
//  Zap-Challenge
//
//  Created by Michael Douglas on 07/02/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

//**********************************************************************************************************
//
// MARK: - Extension - UIColor
//
//**********************************************************************************************************

extension UIColor {
    
    struct ZAP {
        static var purple: UIColor { return UIColor(hexadecimal: 0x6034B1) }
        static var purpleLight: UIColor { return UIColor(hexadecimal: 0x6441A5) }
    }
    
    convenience init(hexadecimal: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hexadecimal >> 16) & 0xff)
        let green = CGFloat((hexadecimal >> 8) & 0xff)
        let blue = CGFloat(hexadecimal & 0xff)
        
        self.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
    
    convenience init(string: String) {
        let hexaString = "0x\(string)"
        let scanner = Scanner(string: hexaString)
        var value: UInt64 = 0
        
        if scanner.scanHexInt64(&value) {
            self.init(hexadecimal: Int(value))
        } else {
            self.init()
        }
    }
}

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
    
    //*************************
    // Favorite Games
    //*************************
    static var favorites: String { return "ST_FAVORITES".localized }
    static var noFavorites: String { return "ST_NO_FAVORITE".localized }
    
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
}

//**********************************************************************************************************
//
// MARK: - Extension - String Formatted
//
//**********************************************************************************************************

extension String {
	
//**************************************************
// MARK: - Protected Methods
//**************************************************
	
	private func attribute(for font: UIFont,
						   with trait: UIFontDescriptorSymbolicTraits,
						   color: UIColor? = nil) -> [String : Any] {
		
		let size = font.pointSize
		var newFont: UIFont
		
		if let descriptor = font.fontDescriptor.withSymbolicTraits(trait) {
			
			newFont = UIFont(descriptor: descriptor, size: size)
			
			if trait == .traitBold {
				newFont = UIFont(name: "\(font.fontName)-Bold", size: size) ?? newFont
			}
		} else {
			newFont = UIFont.systemFont(ofSize: size)
		}
		
		if let newColor = color {
      return [NSAttributedStringKey.font.rawValue : newFont, NSAttributedStringKey.foregroundColor.rawValue : newColor]
		}
		
    return [NSAttributedStringKey.font.rawValue : newFont]
	}
	
//**************************************************
// MARK: - Exposed Methods
//**************************************************
	
	func formatted(with font: UIFont, underline: CGFloat = 2.0) -> NSAttributedString {
		let boldStyle = self.attribute(for: font, with: .traitBold)
		let boldBlackStyle = self.attribute(for: font, with: .traitBold, color: UIColor.black)
		let italicStyle = self.attribute(for: font, with: .traitItalic)
    let underlineStyle = [NSAttributedStringKey.underlineStyle : underline]
		let replacements = [
			"\\∫.*?\\∫" : boldBlackStyle,
			"\\#.*?\\#" : boldStyle,
			"\\$.*?\\$" : italicStyle,
			"\\%.*?\\%" : underlineStyle
      ] as [String : Any]
		
		let att = NSMutableAttributedString(string: self)
		let firstRange = NSRange(location: 0, length: self.characters.count)
    att.setAttributes([ NSAttributedStringKey.font : font ], range: firstRange)
		
		// Loop through all the replacements once to find every single occurence of the patterns.
		for (pattern, attributes) in replacements {
			if let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) {
				var fullRange = NSRange(location: 0, length: att.string.characters.count)
				
				// Loop while there is a first match.
				while let match = regex.firstMatch(in: att.string, options: [], range: fullRange) {
					let range = match.range
          att.addAttributes(attributes as! [NSAttributedStringKey : Any], range: range)
					att.deleteCharacters(in: NSRange(location: range.location, length: 1))
					att.deleteCharacters(in: NSRange(location: range.location + range.length - 2, length: 1))
					fullRange = NSRange(location: 0, length: att.string.characters.count)
				}
			}
		}
		
		return att
	}
}

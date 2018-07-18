//
//  GameDetailsViewModel.swift
//  Zap-Challenge
//
//  Created by Michael Douglas on 14/02/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

//*************************************************
// MARK: - Class -
//*************************************************

public class GameDetailsViewModel: NSObject {
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    public var gameRank: GameRank
    
    public var headerTitle: String {
        return self.gameRank.game?.name ?? ""
    }
    
    public var name: String? {
        if let name = self.gameRank.game?.name {
            return "#\(self.index + 1) \(name)"
        } else {
            return nil
        }
    }
    
    public var isFavorite: Bool {
        return self.gameRank.isFavorite
    }
    
    public var imageURL: URL? {
        return URL(string: self.gameRank.game?.box?.large ?? "")
    }
    
    public var viewers: NSAttributedString {
        let viewersString: String = self.gameRank.viewers?.toDecimalFormat() ?? ""
        let mutable = NSMutableAttributedString(string: "\(viewersString) \(String.ZAP.viewers)")
        
        if let range = mutable.string.range(of: viewersString),
            let font =  UIFont(name: "HelveticaNeue-Bold", size: 15) {
            mutable.addAttribute(NSAttributedStringKey.font,
                                 value: font,
                                 range: mutable.string.nsRange(from: range))
        }
        
        return mutable
    }
    
    //*************************************************
    // MARK: - Private Properties
    //*************************************************
    
    private var provider: GameDetailsProvider
    private var index: Int
    
    //*************************************************
    // MARK: - Initializers
    //*************************************************
    
    init(provider: GameDetailsProvider, gameRank: GameRank, index: Int) {
        self.provider = provider
        self.gameRank = gameRank
        self.index = index
    }
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    // Data
    public func addFavoriteGame() {
        self.gameRank.isFavorite = true
        self.provider.addFavoriteGame(self.gameRank)
    }
    
    public func removeFavoriteGame() {
        self.gameRank.isFavorite = false
        self.provider.removeFavoriteGame(self.gameRank)
    }
}

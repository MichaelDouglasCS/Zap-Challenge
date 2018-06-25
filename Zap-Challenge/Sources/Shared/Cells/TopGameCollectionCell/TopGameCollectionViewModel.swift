//
//  TopGameCollectionViewModel.swift
//  Zap-Challenge
//
//  Created by Michael Douglas on 10/02/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

//**********************************************************************************************************
//
// MARK: - Class -
//
//**********************************************************************************************************

public class TopGameCollectionViewModel: NSObject {
    
    //*************************************************
    // MARK: - Properties
    //*************************************************
    
    public static let cellNib: UINib = UINib(nibName: "TopGameCollectionViewCell", bundle: nil)
    public static let reuseIdentifier: String = "TopGameCollectionViewCell"
    
    public var gameRank: GameRank?
    private var index: Int
    
    public var name: String? {
        if let name = self.gameRank?.game?.name {
            return "#\(self.index + 1) \(name)"
        } else {
            return nil
        }
    }
    
    public var isFavorite: Bool {
        return self.gameRank?.isFavorite ?? false
    }
    
    public var imageURL: URL? {
        return URL(string: self.gameRank?.game?.box?.large ?? "")
    }
    
    //*************************************************
    // MARK: - Initializers
    //*************************************************
    
    public init(gameRank: GameRank?, index: Int) {
        self.gameRank = gameRank
        self.index = index
    }
}

//
//  TopGameCollectionViewModel.swift
//  Zap-Challenge
//
//  Created by Michael Douglas on 10/02/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import Foundation

//**********************************************************************************************************
//
// MARK: - Class -
//
//**********************************************************************************************************

public class TopGameCollectionViewModel: NSObject {
  
  //*************************************************
  // MARK: - Properties
  //*************************************************
  
  public static let cellNibName: String = "TopGameCollectionViewCell"
  
  private var gameRank: GameRank?
  
  public var name: String? {
    return self.gameRank?.game?.name
  }
  
  public var imageURL: URL? {
    return URL(string: self.gameRank?.game?.box?.large ?? "")
  }
  
  //*************************************************
  // MARK: - Initializers
  //*************************************************
  
  public init(gameRank: GameRank?) {
    self.gameRank = gameRank
  }
}

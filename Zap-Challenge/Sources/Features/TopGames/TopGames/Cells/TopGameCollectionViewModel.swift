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
  
  private var game: Game?
  
  public var name: String? {
    return self.game?.name
  }
  
  public var imageURL: URL? {
    return URL(string: self.game?.box?.large ?? "")
  }
  
  //*************************************************
  // MARK: - Initializers
  //*************************************************
  
  public init(game: Game?) {
    self.game = game
  }
}

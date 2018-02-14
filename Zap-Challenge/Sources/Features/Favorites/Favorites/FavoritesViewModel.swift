//
//  FavoritesViewModel.swift
//  Zap-Challenge
//
//  Created by Michael Douglas on 14/02/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

//**********************************************************************************************************
//
// MARK: - Class -
//
//**********************************************************************************************************

public class FavoritesViewModel: NSObject {
  
  //*************************************************
  // MARK: - Properties
  //*************************************************
  
  private var provider: FavoritesProvider
  
  public let headerTitle: String = String.ZAP.favorites
  public let placeholderImage: UIImage = UIImage.ZAP.favoritesPlaceholder
  public let placeholderMessage: String = String.ZAP.noFavorites
  public var isShowPlaceholder: Bool {
    return self.favoriteGames.isEmpty
  }
  public var favoriteGames: [GameRank] = []
  
  //*************************************************
  // MARK: - Initializers
  //*************************************************
  
  init(provider: FavoritesProvider) {
    self.provider = provider
  }
  
  //*************************************************
  // MARK: - Exposed Methods
  //*************************************************
  
  // Data
  
  public func loadFavoriteGames() {
    self.favoriteGames = self.provider.loadFavoriteGames().sorted(by: { $0.viewers ?? 0 > $1.viewers ?? 0 })
  }
  
  public func removeFavoriteGame(_ game: GameRank?) {
    if let gameRank = game {
      gameRank.isFavorite = false
      self.provider.removeFavoriteGame(gameRank)
      self.loadFavoriteGames()
    }
  }
  
  // UICollectionView - Items
  
  public func numberOfSections() -> Int {
    return 1
  }
  
  public func numberOfItems() -> Int {
    return self.favoriteGames.count
  }
  
  public func cellViewModel(at indexPath: IndexPath) -> Any {
    return TopGameCollectionViewModel(gameRank: self.favoriteGames[indexPath.row])
  }
  
  public func insetForSection() -> UIEdgeInsets {
    return UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
  }
  
  public func minimumLineSpacingForSection() -> CGFloat {
    return CGFloat(10.0)
  }
  
  public func minimumInteritemSpacingForSection() -> CGFloat {
    return CGFloat(10.0)
  }
  
  public func sizeForItem(fromView view: UIView) -> CGSize {
    let padding = self.insetForSection().left + self.insetForSection().right + self.minimumInteritemSpacingForSection()
    let width = (view.bounds.size.width - padding) / 2
    let height = width * 1.5 //Ratio
    return CGSize(width: width, height: height)
  }
}

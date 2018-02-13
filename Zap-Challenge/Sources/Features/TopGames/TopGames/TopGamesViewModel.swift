//
//  TopGamesViewModel.swift
//  Zap-Challenge
//
//  Created by Michael Douglas on 08/02/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

public class TopGamesViewModel: NSObject {
  
  //*************************************************
  // MARK: - Properties
  //*************************************************
  
  public var provider: TopGamesProvider
  
  public let headerTitle: String = String.ZAP.topGames
  public var isLoading: Bool = false
  public var isPullToRefresh: Bool = false {
    didSet {
      if self.isPullToRefresh {
        self.games = []
      }
    }
  }
  public var games: [GameRank] = []
  
  var footerView: LoadingFooterCollectionView?
  
  //*************************************************
  // MARK: - Initializers
  //*************************************************
  
  init(provider: TopGamesProvider) {
    self.provider = provider
  }

  //*************************************************
  // MARK: - Exposed Methods
  //*************************************************
  
  // Load Data
  
  public func loadTopGames(completion: @escaping (_ isSuccess: Bool, _ localizedError: String) -> Void) {
    self.provider.loadTopGames(with: 20, from: self.games.count) { (topGames, error) in
      if let topGames = topGames {
        //Sorted by viewers
        if self.games.isEmpty {
          self.games = topGames.sorted(by: { $0.viewers ?? 0 > $1.viewers ?? 0 })
        } else {
          let newGames = topGames.filter({ !self.games.contains($0) }).sorted(by: { $0.viewers ?? 0 > $1.viewers ?? 0 })
          self.games.append(contentsOf: newGames)
        }
      }
      completion(topGames != nil, error ?? "")
    }
  }
  
  public func isLastGame() -> Bool {
    return self.games.count >= self.provider.getTopGamesTotal()
  }
  
  // UICollectionView - Items
  
  public func numberOfSections() -> Int {
    return 1
  }
  
  public func numberOfItems() -> Int {
    return self.games.count
  }
  
  public func cellViewModel(at indexPath: IndexPath) -> Any {
    return TopGameCollectionViewModel(game: self.games[indexPath.row].game)
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
  
  // UICollectionView - FooterView
  
  public func referenceSizeForFooter(fromView view: UIView) -> CGSize {
    return self.isLoading || self.isLastGame() ? .zero : CGSize(width: view.bounds.size.width, height: 40.0)
  }
  
  public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    
    if let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: LoadingFooterCollectionViewModel.reuseIdentifier, for: indexPath) as? LoadingFooterCollectionView, kind == UICollectionElementKindSectionFooter, !self.isLastGame() {
      self.footerView = footerView
      self.footerView?.backgroundColor = .clear
      self.footerView?.startAnimate()
      return self.footerView!
    } else {
      let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: LoadingFooterCollectionViewModel.reuseIdentifier, for: indexPath)
      return headerView
    }
  }
}

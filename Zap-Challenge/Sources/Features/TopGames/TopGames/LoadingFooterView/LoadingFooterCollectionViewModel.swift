//
//  LoadingFooterCollectionViewModel.swift
//  Zap-Challenge
//
//  Created by Michael Douglas on 12/02/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

//**********************************************************************************************************
//
// MARK: - Class -
//
//**********************************************************************************************************

public class LoadingFooterCollectionViewModel: NSObject {
  
  //*************************************************
  // MARK: - Properties
  //*************************************************

  public static var viewNib: UINib = UINib(nibName: "LoadingFooterCollectionView", bundle: nil)
  public static var reuseIdentifier: String = "LoadingFooterCollectionView"
}

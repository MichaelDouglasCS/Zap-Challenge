//
//  UIView+Loading.swift
//  Zap-Challenge
//
//  Created by Michael Douglas on 09/02/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

//**********************************************************************************************************
//
// MARK: - Extension -
//
//**********************************************************************************************************

//**************************************************************************************************
//
// MARK: - Extension - UIView
//
//**************************************************************************************************

extension UIView {
  
  func showLoading(isShow: Bool,
                   at point: CGPoint? = nil,
                   isLarge: Bool = false, color: UIColor? = nil) {
    
    DispatchQueue.main.async {
      if isShow {
        let viewHeight = self.frame.height
        let viewWidth = self.frame.width
        let indicator = UIActivityIndicatorView()
        
        indicator.activityIndicatorViewStyle = isLarge ? .whiteLarge : .white
        indicator.color = color ?? UIColor.lightGray
        indicator.center = CGPoint(x: point?.x ?? (viewWidth/2), y: point?.y ?? (viewHeight/2))
        indicator.startAnimating()
        
        self.addSubview(indicator)
      } else {
        self.subviews.forEach({ (view) in
          if let indicator = view as? UIActivityIndicatorView {
            indicator.stopAnimating()
            indicator.removeFromSuperview()
          }
        })
      }
    }
  }
}

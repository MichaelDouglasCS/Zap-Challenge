//
//  UIViewController+Alerts.swift
//  Zap-Challenge
//
//  Created by Michael Douglas on 10/02/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit
import AlamofireImage

//**********************************************************************************************************
//
// MARK: - Extension -
//
//**********************************************************************************************************

extension UIImageView {
  
  ///////////////////////////
  // MARK: Private Methods
  ///////////////////////////
  
  public func downloadImage(from url: URL,
                            withPlaceholder placeholder: UIImage?,
                            completion: ((_ image: UIImage?) -> Void)? = nil ) {
    self.af_setImage(withURL: url,
                     placeholderImage: placeholder,
                     filter: nil,
                     progress: nil,
                     progressQueue: DispatchQueue.main,
                     imageTransition: .crossDissolve(0.2),
                     runImageTransitionIfCached: false) { (dataResponse) in
                      // do nothing
                      if let theImage = dataResponse.result.value {
                        self.image = theImage
                      } else if let data = dataResponse.data, let theImage = UIImage(data: data) {
                        self.image = theImage
                      } else {
                        self.image = nil
                      }
                      
                      completion?(self.image)
                      
                      print("Finished image download")
    }
    
  }
  
}

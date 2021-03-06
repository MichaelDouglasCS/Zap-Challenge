//
//  LoadingFooterCollectionView.swift
//  Zap-Challenge
//
//  Created by Michael Douglas on 12/02/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

//*************************************************
// MARK: - Class -
//*************************************************

class LoadingFooterCollectionView: UICollectionReusableView {
    
    //*************************************************
    // MARK: - Outlets
    //*************************************************
    
    @IBOutlet weak var refreshControlIndicator: UIActivityIndicatorView!
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    public static var viewNib: UINib = UINib(nibName: "LoadingFooterCollectionView", bundle: nil)
    public static var reuseIdentifier: String = "LoadingFooterCollectionView"
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    func startAnimate() {
        self.refreshControlIndicator?.startAnimating()
    }
    
    func stopAnimate() {
        self.refreshControlIndicator?.stopAnimating()
    }
    
    //*************************************************
    // MARK: - Overridden Public Methods
    //*************************************************
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

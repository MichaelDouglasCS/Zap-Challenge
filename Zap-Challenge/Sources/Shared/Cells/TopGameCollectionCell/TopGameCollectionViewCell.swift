//
//  TopGameCollectionViewCell.swift
//  Zap-Challenge
//
//  Created by Michael Douglas on 10/02/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

//*************************************************
// MARK: - Definition - TopGameCollectionViewCellDelegate
//*************************************************

protocol TopGameCollectionViewCellDelegate: class {
    func didTouchAddFavoriteGame(_ game: GameRank?)
    func didTouchRemoveFavoriteGame(_ game: GameRank?)
}

//*************************************************
// MARK: - Class -
//*************************************************

class TopGameCollectionViewCell: UICollectionViewCell {
    
    //*************************************************
    // MARK: - Outlets
    //*************************************************
    
    @IBOutlet weak var backgroundBlurView: UIImageView!
    @IBOutlet weak var imageView: CircularImage!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    var viewModel: TopGameCollectionViewModel!
    weak var delegate: TopGameCollectionViewCellDelegate!
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    func setup() {
        
        if let url = self.viewModel.imageURL {
            
            self.backgroundBlurView.image = UIImage.ZAP.joystickPlaceholder
            self.imageView.contentMode = .scaleAspectFit
            
            self.imageView.downloadImage(from: url,
                                         withPlaceholder: UIImage.ZAP.joystickPlaceholder,
                                         completion: { (_) in
                                            self.backgroundBlurView.image = self.imageView.image
                                            self.imageView.contentMode = .scaleAspectFill
            })
        }
        
        self.nameLabel.text = self.viewModel.name
        self.favoriteButton.isSelected = self.viewModel.isFavorite
    }
    
    @IBAction func didTouchFavorite(_ sender: UIButton) {
        if !self.viewModel.isFavorite {
            self.delegate.didTouchAddFavoriteGame(self.viewModel.gameRank)
        } else {
            self.delegate.didTouchRemoveFavoriteGame(self.viewModel.gameRank)
        }
        self.favoriteButton.isSelected = self.viewModel.isFavorite
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.1, animations: {
                self.favoriteButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }, completion: { _ in
                UIView.animate(withDuration: 0.1) {
                    self.favoriteButton.transform = .identity
                }
            })
        }
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

//
//  GameDetailsViewController.swift
//  Zap-Challenge
//
//  Created by Michael Douglas on 14/02/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

//*************************************************
// MARK: - Class -
//*************************************************

class GameDetailsViewController: UIViewController {
    
    //*************************************************
    // MARK: - Outlets
    //*************************************************
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var viewersLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIBarButtonItem! {
        didSet {
            let iconButton = UIButton(frame: CGRect(origin: .zero, size: UIImage.ZAP.favoritesUnselected.size))
            iconButton.setBackgroundImage(UIImage.ZAP.favoritesUnselected, for: .normal)
            iconButton.setBackgroundImage(UIImage.ZAP.favoritesSelected, for: .selected)
            iconButton.addTarget(self, action: #selector(self.didTouchFavorite), for: .touchUpInside)
            self.favoriteButton.customView = iconButton
        }
    }
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    var viewModel: GameDetailsViewModel!
    
    //*************************************************
    // MARK: - Private Properties
    //*************************************************
    
    private var isFavorite: Bool = false {
        didSet {
            if let favoriteButton = self.favoriteButton.customView as? UIButton {
                favoriteButton.isSelected = self.isFavorite
            }
        }
    }
    
    //*************************************************
    // MARK: - Lifecycle
    //*************************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Change Status Bar Style
        UIApplication.shared.statusBarStyle = .lightContent
        
        // Navigation
        self.navigationItem.title = self.viewModel.headerTitle 
        
        // Load Data
        if let url = self.viewModel.imageURL {
            self.backgroundImage.image = UIImage.ZAP.joystickPlaceholder
            self.imageView.contentMode = .scaleAspectFit
            
            self.imageView.downloadImage(from: url,
                                         withPlaceholder: UIImage.ZAP.joystickPlaceholder,
                                         completion: { (_) in
                                            self.backgroundImage.image = self.imageView.image
                                            self.imageView.contentMode = .scaleAspectFill
            })
        }
        
        self.isFavorite = self.viewModel.isFavorite
        self.nameLabel.text = self.viewModel.name
        self.viewersLabel.attributedText = self.viewModel.viewers
    }
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    @objc func didTouchFavorite() {
        if !self.viewModel.isFavorite {
            self.viewModel.addFavoriteGame()
        } else {
            self.viewModel.removeFavoriteGame()
        }
        self.isFavorite = self.viewModel.isFavorite
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.1, animations: {
                self.favoriteButton.customView?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }, completion: { _ in
                UIView.animate(withDuration: 0.1) {
                    self.favoriteButton.customView?.transform = .identity
                }
            })
        }
    }
}

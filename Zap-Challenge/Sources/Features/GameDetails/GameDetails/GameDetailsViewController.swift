//
//  GameDetailsViewController.swift
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

class GameDetailsViewController: UIViewController {
    
    //*************************************************
    // MARK: - Properties
    //*************************************************
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var viewersLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    private var isFavorite: Bool = false {
        didSet {
            self.favoriteButton.image = self.isFavorite ? UIImage.ZAP.favoritesSelected : UIImage.ZAP.favoritesUnselected
        }
    }
    
    var viewModel: GameDetailsViewModel!
    
    //*************************************************
    // MARK: - Life Cycle
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
    // MARK: - Exposed Methods
    //*************************************************
    
    @IBAction func didTouchFavorite(_ sender: UIBarButtonItem) {
        if !self.viewModel.isFavorite {
            self.viewModel.addFavoriteGame()
        } else {
            self.viewModel.removeFavoriteGame()
        }
        self.isFavorite = self.viewModel.isFavorite
    }
}

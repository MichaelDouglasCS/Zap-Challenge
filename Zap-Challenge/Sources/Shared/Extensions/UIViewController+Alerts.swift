//
//  UIViewController+Alerts.swift
//  Zap-Challenge
//
//  Created by Michael Douglas on 07/02/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

//**********************************************************************************************************
//
// MARK: - Extension - UIViewController
//
//**********************************************************************************************************

extension UIViewController {

//**************************************************
// MARK: - Protected Methods
//**************************************************

	private static func generateAlert(for title: String, message: Any) -> UIAlertController {
		let attMsg = message as? NSAttributedString
		let stringMsg = message as? String ?? ""
		let alert = UIAlertController(title: title, message: stringMsg, preferredStyle: .alert)
		
		if let attributed = attMsg {
			alert.setValue(attributed, forKey: "attributedMessage")
		}
		
		return alert
	}
	
//**************************************************
// MARK: - Exposed Methods
//**************************************************
	
	func showInfoAlert(title: String, message: Any, completion: ((UIAlertAction) -> Void)? = nil) {
		let alert = UIViewController.generateAlert(for: title, message: message)
		let defaultAction = UIAlertAction(title: String.ZAP.ok, style: .default, handler: completion)
		
		alert.addAction(defaultAction)
		self.present(alert, animated: true, completion: nil)
	}
	
	func showActionAlert(title: String, message: Any, actions: UIAlertAction...) {
		let alert = UIViewController.generateAlert(for: title, message: message)
		
		for action in actions {
			alert.addAction(action)
		}
		
		self.present(alert, animated: true, completion: nil)
	}
}

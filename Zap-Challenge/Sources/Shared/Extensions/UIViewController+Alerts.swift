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
// MARK: - Properties
//**************************************************

	static let loading: UIAlertController = {
		return UIViewController.generateAlert(for: String.Local.loading, message: String.Local.wait)
	}()
	
	static let syncing: UIAlertController = {
		return UIViewController.generateAlert(for: String.Local.syncing, message: String.Local.wait)
	}()
	
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
		let defaultAction = UIAlertAction(title: String.Local.ok, style: .default, handler: completion)
		
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
	
	func showFieldAlert(title: String, message: Any, completion: ((String?) -> Void)? = nil) {
		let alert = UIViewController.generateAlert(for: title, message: message)
		let cancelAction = UIAlertAction(title: String.Local.cancel, style: .cancel, handler: nil)
		let defaultAction = UIAlertAction(title: String.Local.ok, style: .default) { _ in
			if let textField = alert.textFields?.first {
				completion?(textField.text)
			}
		}
		
		alert.addTextField {
			$0.placeholder = String.Local.typeHere
		}
		
		alert.addAction(cancelAction)
		alert.addAction(defaultAction)
		self.present(alert, animated: true, completion: nil)
	}
	
	func showLoadingAlert(completion: (() -> Void)? = nil) {
		self.present(UIViewController.loading, animated: true, completion: completion)
	}
	
	func hidesLoadingAlert(completion: (() -> Void)? = nil) {
		UIViewController.loading.dismiss(animated: false, completion: completion)
	}
	
	func showSyncingAlert(completion: (() -> Void)? = nil) {
		self.present(UIViewController.syncing, animated: true, completion: completion)
	}
	
	func hidesSyncingAlert(completion: (() -> Void)? = nil) {
		UIViewController.syncing.dismiss(animated: false, completion: completion)
	}

}

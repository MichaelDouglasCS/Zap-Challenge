/*
 *	LocalizedTabBar.swift
 *	Harmony
 *
 *	Created by Diney on 06/12/16.
 *	Copyright 2016 Merck. All rights reserved.
 */

import UIKit

//**********************************************************************************************************
//
// MARK: - Class -
//
//**********************************************************************************************************

@IBDesignable
class LocalizedTabBar: UITabBar {

//**************************************************
// MARK: - Overridden Methods
//**************************************************
	
	override func setItems(_ items: [UITabBarItem]?, animated: Bool) {
		items?.forEach {
			$0.title = $0.title?.localized
		}
		super.setItems(items, animated: animated)
	}
}

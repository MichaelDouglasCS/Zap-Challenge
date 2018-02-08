/*
 *	LocalizedNavigationBar.swift
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

class LocalizedNavigationBar: UINavigationBar {

//**************************************************
// MARK: - Properties
//**************************************************

	override var topItem: UINavigationItem? {
		let item = super.topItem
		
		item?.title = item?.title?.localized
		
		return item
	}

}

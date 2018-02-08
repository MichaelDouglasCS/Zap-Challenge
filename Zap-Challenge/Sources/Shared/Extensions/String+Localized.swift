//
//  String+Localized.swift
//  Zap-Challenge
//
//  Created by Michael Douglas on 07/02/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

//**********************************************************************************************************
//
// MARK: - Extension - String Local
//
//**********************************************************************************************************

extension String {
	
	struct Local {
    
		//*************************
		// Labels
		//*************************
		static var open: String { return "LB_OPEN".localized }
		static var submitted: String { return "LB_SUBMITTED".localized }
		static var returned: String { return "LB_RETURNED".localized }
		static var receivedDate: String { return "LB_RECEIVED_DATE".localized }
		static var assignedDate: String { return "LB_ASSIGNED_DATE".localized }
		static var targetDate: String { return "LB_TARGET_DATE".localized }
		static var submittedDate: String { return "LB_SUBMITTED_DATE".localized }
		static var returnedDate: String { return "LB_RETURNED_DATE".localized }
		static var select: String { return "LB_SELECT".localized }
		static var typeHere: String { return "LB_TYPE_HERE".localized }
		static var noResults: String { return "LB_NO_RESULTS".localized }
		static var intakeNumber: String { return "LB_INTAKE_#:".localized }
		static var start: String { return "LB_START".localized }
		static var cancel: String { return "LB_CANCEL".localized }
		static var close: String { return "LB_CLOSE".localized }
		static var resume: String { return "LB_RESUME".localized }
		static var edit: String { return "LB_EDIT".localized }
		static var view: String { return "LB_VIEW".localized }
		
		//*************************
		// Strings
		//*************************
		static var priority: String { return "ST_PRIORITY".localized }
		static var priorityA: String { return "ST_PRIORITY_A".localized }
		static var priorityB: String { return "ST_PRIORITY_B".localized }
		static var priorityC: String { return "ST_PRIORITY_C".localized }
		static var priorityD: String { return "ST_PRIORITY_D".localized }
		static var priorityE: String { return "ST_PRIORITY_E".localized }
		static var priorityF: String { return "ST_PRIORITY_F".localized }
		static var priorityG: String { return "ST_PRIORITY_G".localized }
		static var priorityH: String { return "ST_PRIORITY_H".localized }
		static var recent: String { return "ST_RECENT".localized }
		static var custom: String { return "ST_CUSTOM".localized }
		static var ok: String { return "ST_OK".localized }
		static var sorry: String { return "ST_SORRY".localized }
		static var loading: String { return "ST_LOADING".localized }
		static var violation: String { return "ST_VIOLATION".localized }
		static var violationAlert: String { return "ST_VIOLATION_ALERT".localized }
		static var rfoSoft: String { return "ST_RFO_SOFT".localized }
		static var rfoNeedles: String { return "ST_RFO_NEEDLES".localized }
		static var rfoInstrument: String { return "ST_RFO_INSTRUMENT".localized }
		static var rfoMiscellaneous: String { return "ST_RFO_MISCELLANEOUS".localized }
		static var rfoOther: String { return "ST_RFO_OTHER".localized }
		static var pictureSource: String { return "ST_PICTURE_SOURCE".localized }
		static var camera: String { return "ST_CAMERA".localized }
		static var photoLibrary: String { return "ST_PHOTO_LIBRARY".localized }
		static var delete: String { return "ST_DELETE".localized }
		static var yes: String { return "ST_YES".localized }
		static var no: String { return "ST_NO".localized }
		static var selectViolation: String { return "ST_SELECT_VIOLATION".localized }
		static var currentViolations: String { return "ST_CURRENT_VIOLATIONS".localized }
		static var suggested: String { return "ST_SUGGESTED".localized }
		static var alert: String { return "ST_ALERT".localized }
		static var directionsSource: String { return "ST_DIRECTIONS_SOURCE".localized }
		static var noFilters: String { return "ST_NO_FILTER".localized }
		static var jobAid: String { return "ST_INVESTIGATION".localized }
		static var facilityID: String { return "ST_FACILITY_ID".localized }
		static var providerNumber: String { return "ST_PROVIDER_NUMBER".localized }
		static var licenseNumber: String { return "ST_LICENSE_NUMBER".localized }
		static var type: String { return "ST_TYPE".localized }
		static var administrator: String { return "ST_ADMINISTRATOR".localized }
		static var takenByStaff: String { return "ST_TAKEN_BY".localized }
		static var locationReceived: String { return "ST_LOCATION_RECEIVED".localized }
		static var intakeType: String { return "ST_INTAKE_TYPE".localized }
		static var intakeSubType: String { return "ST_INTAKE_SUB_TYPE".localized }
		static var saContact: String { return "ST_SA_CONTACT".localized }
		static var roContact: String { return "ST_RO_CONTACT".localized }
		static var responsibleTeam: String { return "ST_RESPONSIBLE_TEAM".localized }
		static var source: String { return "ST_SOURCE".localized }
		static var receivedStart: String { return "ST_RECEIVED_START".localized }
		static var receivedEnd: String { return "ST_RECEIVED_END".localized }
		static var receivedBy: String { return "ST_RECEIVED_BY".localized }
		static var name: String { return "ST_NAME".localized }
		static var confidentiality: String { return "ST_CONFIDENTIALITY".localized }
		static var address: String { return "ST_ADDRESS".localized }
		static var phone: String { return "ST_PHONE".localized }
		static var email: String { return "ST_EMAIL".localized }
		static var dateOfAllegedEvent: String { return "ST_DATE_OF_ALLEGED_EVENT".localized }
		static var time: String { return "ST_TIME".localized }
		static var standardNotes: String { return "ST_STANDARD_NOTES".localized }
		static var category: String { return "ST_CATEGORY".localized }
		static var subCategory: String { return "ST_SUB_CATEGORY".localized }
		static var seriousness: String { return "ST_SERIOUSNESS".localized }
		static var details: String { return "ST_DETAILS".localized }
		static var eventID: String { return "ST_EVENT_ID".localized }
		static var startDate: String { return "ST_START_DATE".localized }
		static var exitDate: String { return "ST_EXIT_DATE".localized }
		static var teamMembers: String { return "ST_TEAM_MEMBER".localized }
		static var providerInfo: String { return "ST_PROVIDER_INFO".localized }
		static var intakeInfo: String { return "ST_INTAKE_INFO".localized }
		static var complainants: String { return "ST_COMPLAINANTS".localized }
		static var intakeDetails: String { return "ST_INTAKE_DETAILS".localized }
		static var allegations: String { return "ST_ALLEGATIONS".localized }
		static var surveyInfo: String { return "ST_SURVEY_INFO".localized }
		static var activities: String { return "ST_ACTIVITIES".localized }
		static var notes: String { return "ST_NOTES".localized }
		static var history: String { return "ST_HISTORY".localized }
		static var investigationDetails: String { return "ST_INVESTIGATION_DETAILS".localized }
		static var violationDetails: String { return "ST_VIOLATION_DETAILS".localized }
		static var sent: String { return "ST_SENT".localized }
		static var due: String { return "ST_DUE".localized }
		static var completed: String { return "ST_COMPLETED".localized }
		static var responsibleStaff: String { return "ST_RESPONSIBLE_STAFF".localized }
		static var reasonRestraint: String { return "ST_REASON_RESTRAINT".localized }
		static var causeDeath: String { return "ST_CAUSE_DEATH".localized }
		static var prev: String { return "ST_PREV".localized }
		static var next: String { return "ST_NEXT".localized }
		static var syncing: String { return "ST_SYNCING".localized }
		
		//*************************
		// Messages
		//*************************
		static var unknown: String { return "MSG_UNKNOWN".localized }
		static var serverError: String { return "MSG_SERVER_ERROR".localized }
		static var fileError: String { return "MSG_FILE_ERROR".localized }
		static var wait: String { return "MSG_WAIT".localized }
		static var discard: String { return "MSG_DISCARD".localized }
		static var noItems: String { return "MSG_OUT_OF_ITEMS".localized }
		static var noDirections: String { return "MSG_NO_DIRECTIONS".localized }
		static var emptyList: String { return "MSG_EMPTY_LIST".localized }
		static var emptyListSwipe: String { return "MSG_EMPTY_LIST_SWIPE".localized }
		static var insertLogin: String { return "MSG_INSERT_LOGIN".localized }
		static var fingerPrint: String { return "MSG_FINGER_PRINT".localized }
		static var invalidFingerPrint: String { return "MSG_INVALID_FINGER_PRINT".localized }
		static var invalidLogin: String { return "MSG_INVALID_LOGIN".localized }
		static var deviceAuth: String { return "MSG_DEVICE_AUTH".localized }
		static var devicePush: String { return "MSG_DEVICE_PUSH".localized }
		static var localTarget: String { return "MSG_LOCAL_TARGET_DATE".localized }
		static var sendEmail: String { return "MSG_SEND_EMAIL".localized }
		static var investigationFinished: String { return "MSG_INVESTIGATION_WAS_FINISHED".localized }
		static var investigationSent: String { return "MSG_INVESTIGATION_WAS_SENT".localized }
		static var findInMailbox: String { return "MSG_FIND_IN_MAILBOX".localized }
		
		//*************************
		// Plurals
		//*************************
		static var hours: String { return "PL_HOURS".localized }
		static var days: String { return "PL_DAYS".localized }
		static var lastDays: String { return "PL_LAST_DAYS".localized }
		static var nextDays: String { return "PL_NEXT_DAYS".localized }
	}
}

//**********************************************************************************************************
//
// MARK: - Extension - String Localized
//
//**********************************************************************************************************

extension String {
	
//**************************************************
// MARK: - Exposed Methods
//**************************************************
	
	/**
	Localized string version, using the main bundle and the main table (Localizable.strings) 
	and keeping the record for the original localizable key.
	*/
	var localized: String {
		return NSLocalizedString(self, comment: self)
	}
	
	/**
	Pluralized string version, using the main bundle and the main table (Localizable.stringsdict)
	This function must be called after a call to the localized in order to keep the original version.
	*/
	func pluralized(_ count: Int) -> String {
		return String.localizedStringWithFormat(self, count)
	}
}

//**********************************************************************************************************
//
// MARK: - Extension - String Formatted
//
//**********************************************************************************************************

extension String {
	
//**************************************************
// MARK: - Protected Methods
//**************************************************
	
	private func attribute(for font: UIFont,
						   with trait: UIFontDescriptorSymbolicTraits,
						   color: UIColor? = nil) -> [String : Any] {
		
		let size = font.pointSize
		var newFont: UIFont
		
		if let descriptor = font.fontDescriptor.withSymbolicTraits(trait) {
			
			newFont = UIFont(descriptor: descriptor, size: size)
			
			if trait == .traitBold {
				newFont = UIFont(name: "\(font.fontName)-Bold", size: size) ?? newFont
			}
		} else {
			newFont = UIFont.systemFont(ofSize: size)
		}
		
		if let newColor = color {
      return [NSAttributedStringKey.font.rawValue : newFont, NSAttributedStringKey.foregroundColor.rawValue : newColor]
		}
		
    return [NSAttributedStringKey.font.rawValue : newFont]
	}
	
//**************************************************
// MARK: - Exposed Methods
//**************************************************
	
	func formatted(with font: UIFont, underline: CGFloat = 2.0) -> NSAttributedString {
		let boldStyle = self.attribute(for: font, with: .traitBold)
		let boldBlackStyle = self.attribute(for: font, with: .traitBold, color: UIColor.black)
		let italicStyle = self.attribute(for: font, with: .traitItalic)
    let underlineStyle = [NSAttributedStringKey.underlineStyle : underline]
		let replacements = [
			"\\∫.*?\\∫" : boldBlackStyle,
			"\\#.*?\\#" : boldStyle,
			"\\$.*?\\$" : italicStyle,
			"\\%.*?\\%" : underlineStyle
      ] as [String : Any]
		
		let att = NSMutableAttributedString(string: self)
		let firstRange = NSRange(location: 0, length: self.characters.count)
    att.setAttributes([ NSAttributedStringKey.font : font ], range: firstRange)
		
		// Loop through all the replacements once to find every single occurence of the patterns.
		for (pattern, attributes) in replacements {
			if let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) {
				var fullRange = NSRange(location: 0, length: att.string.characters.count)
				
				// Loop while there is a first match.
				while let match = regex.firstMatch(in: att.string, options: [], range: fullRange) {
					let range = match.range
          att.addAttributes(attributes as! [NSAttributedStringKey : Any], range: range)
					att.deleteCharacters(in: NSRange(location: range.location, length: 1))
					att.deleteCharacters(in: NSRange(location: range.location + range.length - 2, length: 1))
					fullRange = NSRange(location: 0, length: att.string.characters.count)
				}
			}
		}
		
		return att
	}
}

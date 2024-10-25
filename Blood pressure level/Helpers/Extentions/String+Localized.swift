//
//  String+Localized.swift
//  Blood pressure level
//
//  Created by mix on 25.10.2024.
//

import Foundation

extension String {
	var localized: String {
		return NSLocalizedString(self, comment: Constants.General.emptyString)
	}
}

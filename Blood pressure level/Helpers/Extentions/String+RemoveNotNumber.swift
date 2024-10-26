//
//  String+RemoveNotNumber.swift
//  Blood pressure level
//
//  Created by mix on 26.10.2024.
//

import Foundation

extension String {
	func removingNonNumericCharacters() -> String {
		self.filter { $0.isNumber }
	}
}

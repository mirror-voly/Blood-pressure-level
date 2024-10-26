//
//  View+HideKeyboard.swift
//  Blood pressure level
//
//  Created by mix on 26.10.2024.
//

import SwiftUI

extension View {
	func hideKeyboard() {
		UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
	}
}


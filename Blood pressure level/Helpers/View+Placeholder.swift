//
//  View+Placeholder.swift
//  Blood pressure level
//
//  Created by mix on 25.10.2024.
//

import SwiftUI

extension View {
	func placeholder<Content: View>(when shouldShow: Bool, alignment: Alignment = .leading, padding: Edge.Set = .leading, @ViewBuilder placeholder: () -> Content) -> some View {
		ZStack(alignment: alignment) {
			self
			if shouldShow {
				placeholder()
					.font(.system(size: 18))
					.foregroundColor(.secondaryGrayDark)
					.allowsHitTesting(false)
					.padding(padding)
			}
		}
	}
}

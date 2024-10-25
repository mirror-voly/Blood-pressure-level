//
//  AddNewButtonView.swift
//  Blood pressure level
//
//  Created by mix on 25.10.2024.
//

import SwiftUI

struct AddNewButtonView: View {
	
	@Environment(\.dismiss) var dismiss
	let cantBeSaved: Bool
	
    var body: some View {
		Button {
			dismiss()
		} label: {
			Text("save".localized)
				.frame(maxWidth: .infinity)
		}
		.tint(cantBeSaved ? .blue.opacity(Constants.Opacity.regular) : .blue)
		.buttonStyle(BorderedProminentButtonStyle())
		.clipShape(RoundedRectangle(cornerRadius: Constants.Radius.small))
		.allowsHitTesting(!cantBeSaved)
    }
}

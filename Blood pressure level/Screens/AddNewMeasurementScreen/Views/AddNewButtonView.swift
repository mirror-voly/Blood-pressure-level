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
			Text("Сохранить")
				.frame(maxWidth: .infinity)
		}
		.tint(cantBeSaved ? .blue.opacity(0.3) : .blue)
		.buttonStyle(BorderedProminentButtonStyle())
		.clipShape(RoundedRectangle(cornerRadius: Constants.Radius.small))
		.allowsHitTesting(!cantBeSaved)
    }
}

//
//  AddNewButtonView.swift
//  Blood pressure level
//
//  Created by mix on 25.10.2024.
//

import SwiftUI

struct AddNewButtonView: View {
	
	@EnvironmentObject private var viewModel: AddNewMeasurementViewModel
	@Environment(\.dismiss) var dismiss
	
    var body: some View {
		Button {
			viewModel.buttonAction()
			dismiss()
		} label: {
			Text("save".localized)
				.frame(maxWidth: .infinity)
		}
		.tint(viewModel.canNotBeSaved ? .blue.opacity(Constants.Opacity.regular) : .blue)
		.foregroundStyle(.scheme)
		.buttonStyle(BorderedProminentButtonStyle())
		.clipShape(RoundedRectangle(cornerRadius: Constants.Radius.small))
		.allowsHitTesting(!viewModel.canNotBeSaved)
    }
}

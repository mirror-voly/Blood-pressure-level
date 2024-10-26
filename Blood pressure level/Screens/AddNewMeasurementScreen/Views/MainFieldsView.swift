//
//  MainFieldsView.swift
//  Blood pressure level
//
//  Created by mix on 25.10.2024.
//

import SwiftUI

struct MainFieldsView: View {
	
	@StateObject var viewModel: AddNewMeasurementViewModel
	
	var body: some View {
		HStack(alignment: .top, spacing: Constants.Spacing.largeSpacing) {
			VStack(alignment: .leading) {
				Text("blood_pressure".localized)
					.font(.system(size: Constants.FontSize.regular))
				
				HStack(spacing: Constants.Spacing.smallSpacing) {
					VStack(alignment: .leading, spacing: Constants.Spacing.smallSpacing) {
						Text("systolic".localized)
							.font(.system(size: Constants.FontSize.micro))
							.foregroundStyle(.main.opacity(Constants.Opacity.big))
						
						TextFieldView(viewModel: viewModel, placeholder: "120", text: $viewModel.systolicText)
							.onChange(of: viewModel.systolicText) { newValue in
								viewModel.systolicText = newValue.removingNonNumericCharacters()
							}
					}
					
					VStack(alignment: .leading, spacing: Constants.Spacing.smallSpacing) {
						Text("diastolic".localized)
							.font(.system(size: Constants.FontSize.micro))
							.foregroundStyle(.main.opacity(Constants.Opacity.big))
						
						TextFieldView(viewModel: viewModel, placeholder: "90", text: $viewModel.diastolicText)
							.onChange(of: viewModel.diastolicText) { newValue in
								viewModel.diastolicText = newValue.removingNonNumericCharacters()
							}
					}
				}
			}
			.frame(width: Constants.FrameSize.pressureFieldsViewWidth, height: Constants.FrameSize.mainFieldsViewHeight)
			
			VStack(alignment: .leading)   { 
				Text("pulse".localized)
					.font(.system(size: Constants.FontSize.regular))
				
				Spacer()
				
				TextFieldView(viewModel: viewModel, placeholder: "70", text: $viewModel.pulseText)
					.onChange(of: viewModel.pulseText) { newValue in
						viewModel.pulseText = newValue.removingNonNumericCharacters()
					}
			}
		}
		.frame(maxHeight: Constants.FrameSize.mainFieldsViewHeight)
	}
}

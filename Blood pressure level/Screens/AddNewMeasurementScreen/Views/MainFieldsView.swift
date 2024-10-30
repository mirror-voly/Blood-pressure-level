//
//  MainFieldsView.swift
//  Blood pressure level
//
//  Created by mix on 25.10.2024.
//

import SwiftUI

struct MainFieldsView: View {
	
	@EnvironmentObject private var viewModel: AddNewMeasurementViewModel
	
	var body: some View {
		HStack(alignment: .top, spacing: Constants.Spacing.big) {
			VStack(alignment: .leading) {
				Text("blood_pressure".localized)
					.font(.system(size: Constants.FontSize.regular))
				
				HStack(spacing: Constants.Spacing.small) {
					VStack(alignment: .leading, spacing: Constants.Spacing.small) {
						Text("systolic".localized)
							.font(.system(size: Constants.FontSize.verySmall))
							.foregroundStyle(.main.opacity(Constants.Opacity.big))
						
						TextFieldView(text: $viewModel.systolicText,
									  placeholder: Constants.Placeholder.systolicPlaceholder,
									  keyboardType: .decimalPad)
						.onChange(of: viewModel.systolicText) { newValue in
							viewModel.systolicText = newValue.removingNonNumericCharacters()
						}
					}
					
					VStack(alignment: .leading, spacing: Constants.Spacing.small) {
						Text("diastolic".localized)
							.font(.system(size: Constants.FontSize.verySmall))
							.foregroundStyle(.main.opacity(Constants.Opacity.big))
						
						TextFieldView(text: $viewModel.diastolicText,
									  placeholder: Constants.Placeholder.diastolicPlaceholder,
									  keyboardType: .decimalPad)
						.onChange(of: viewModel.diastolicText) { newValue in
							viewModel.diastolicText = newValue.removingNonNumericCharacters()
						}
					}
				}
			}
			.frame(width: Constants.FrameSize.pressureFieldsViewWidth,
				   height: Constants.FrameSize.mainFieldsViewHeight)
			
			VStack(alignment: .leading)   { 
				Text("pulse".localized)
					.font(.system(size: Constants.FontSize.regular))
				
				Spacer()
				
				TextFieldView(text: $viewModel.pulseText,
							  placeholder: Constants.Placeholder.pulsePlaceholder,
							  keyboardType: .decimalPad)
				.onChange(of: viewModel.pulseText) { newValue in
					viewModel.pulseText = newValue.removingNonNumericCharacters()
				}
			}
		}
		.frame(maxHeight: Constants.FrameSize.mainFieldsViewHeight)
	}
}

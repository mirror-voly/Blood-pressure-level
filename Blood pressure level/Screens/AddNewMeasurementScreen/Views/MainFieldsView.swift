//
//  MainFieldsView.swift
//  Blood pressure level
//
//  Created by mix on 25.10.2024.
//

import SwiftUI

struct MainFieldsView: View {
	
	@Binding var systolicTextFieeld: String
	@Binding var diastolicTextFieeld: String
	@Binding var pulseTextFieeld: String
	
	var body: some View {
		HStack(alignment: .top, spacing: Constants.Spacing.largeSpacing) {
			VStack(alignment: .leading) {
				Text("Кровянное давление")
					.font(.system(size: Constants.FontSize.regular))
				
				HStack(spacing: Constants.Spacing.smallSpacing) {
					VStack(alignment: .leading, spacing: Constants.Spacing.smallSpacing) {
						Text("Систолическое")
							.font(.system(size: Constants.FontSize.micro))
							.foregroundStyle(.main.opacity(Constants.Opacity.big))
						
						TextFieldView(placeholder: "120", text: $systolicTextFieeld)
					}
					
					VStack(alignment: .leading, spacing: Constants.Spacing.smallSpacing) {
						Text("Диастолическое")
							.font(.system(size: Constants.FontSize.micro))
							.foregroundStyle(.main.opacity(Constants.Opacity.big))
						
						TextFieldView(placeholder: "90", text: $diastolicTextFieeld)
					}
				}
			}
			.frame(width: Constants.FrameSize.pressureFieldsViewWidth, height: Constants.FrameSize.mainFieldsViewHeight)
			
			VStack(alignment: .leading)   { 
				Text("Пульс")
					.font(.system(size: Constants.FontSize.regular))
				
				Spacer()
				
				TextFieldView(placeholder: "70", text: $pulseTextFieeld)
				
			}
		}
		.frame(maxHeight: Constants.FrameSize.mainFieldsViewHeight)
	}
}

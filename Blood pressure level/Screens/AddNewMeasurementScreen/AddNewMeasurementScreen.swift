//
//  AddNewMeasurementScreen.swift
//  Blood pressure level
//
//  Created by mix on 24.10.2024.
//

import SwiftUI

struct AddNewMeasurementScreen: View {
	
	@StateObject private var viewModel = AddNewMeasurementViewModel(dataStore: DataStore.shared)
	
    var body: some View {
		ZStack {
			BackgroundView(backgroundType: .addNewScreen)
			
			VStack(spacing: Constants.Spacing.defaultSpacing) {
				
				AddNewHeaderView()

				MainFieldsView(viewModel: viewModel)

				DateFields(viewModel: viewModel)
				
				VStack(alignment: .leading) {
					Text("note".localized)
						.font(.system(size: Constants.FontSize.regular))
					
					TextFieldView(viewModel: viewModel, placeholder: "describe_your_condition".localized, text: $viewModel.noteTextFieeld)
				}
				
				Spacer()
				
				AddNewButtonView(viewModel: viewModel)
				
			}
			.padding()
		}
		.navigationBarBackButtonHidden()
		.navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AddNewMeasurementScreen()
}

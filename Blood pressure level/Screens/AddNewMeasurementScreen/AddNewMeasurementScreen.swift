//
//  AddNewMeasurementScreen.swift
//  Blood pressure level
//
//  Created by mix on 24.10.2024.
//

import SwiftUI

struct AddNewMeasurementScreen: View {
	
	@StateObject private var viewModel: AddNewMeasurementViewModel
	
	var body: some View {
		VStack(spacing: Constants.Spacing.regular) {
			AddNewHeaderView()
			
			MainFieldsView()
			
			DateFields()
			
			NoteFieldView()
			
			Spacer()
			
			AddNewButtonView()
			
		}
		.padding()
		.navigationBarBackButtonHidden()
		.navigationBarTitleDisplayMode(.inline)
		.background(BackgroundView(backgroundType: .addNewScreen)
			.onTapGesture {
				hideKeyboard()
			})
		.environmentObject(viewModel)
	}
	
	init(dataStore: DataStore) {
		self._viewModel = StateObject(wrappedValue: AddNewMeasurementViewModel(dataStore: dataStore))
	}
}

#Preview {
	AddNewMeasurementScreen(dataStore: DataStore.shared)
}

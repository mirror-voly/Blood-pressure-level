//
//  NoteFieldView.swift
//  Blood pressure level
//
//  Created by mix on 29.10.2024.
//

import SwiftUI

struct NoteFieldView: View {
	
	@EnvironmentObject private var viewModel: AddNewMeasurementViewModel
	
    var body: some View {
		VStack(alignment: .leading) {
			Text("note".localized)
				.font(.system(size: Constants.FontSize.regular))
			
			TextFieldView(text: $viewModel.noteText, placeholder: "describe_your_condition".localized, keyboardType: .default)
		}
    }
}


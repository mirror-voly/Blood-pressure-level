//
//  NoteFieldView.swift
//  Blood pressure level
//
//  Created by mix on 29.10.2024.
//

import SwiftUI

struct NoteFieldView: View {
	
	@StateObject var viewModel: AddNewMeasurementViewModel
	
    var body: some View {
		VStack(alignment: .leading) {
			Text("note".localized)
				.font(.system(size: Constants.FontSize.regular))
			
			TextFieldView(viewModel: viewModel, placeholder: "describe_your_condition".localized, keyboardType: .default, text: $viewModel.noteText)
		}
    }
}


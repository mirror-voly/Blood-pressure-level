//
//  DateFieldView.swift
//  Blood pressure level
//
//  Created by mix on 25.10.2024.
//

import SwiftUI

struct DateFieldView: View {
	
	@StateObject var viewModel: AddNewMeasurementViewModel
	let displayedComponents: DatePickerComponents
	
    var body: some View {
		ZStack(alignment: .leading, content: {
			DatePicker(Constants.General.emptyString,
					   selection: $viewModel.date,
					   in: viewModel.currentDate...,
					   displayedComponents: displayedComponents)
			.datePickerStyle(.compact)
			.fixedSize()

			Text(viewModel.getDateFieldViewText(displayedComponents: displayedComponents))
				.font(.system(size: Constants.FontSize.big))
				.padding()
				.foregroundStyle(viewModel.datePickerSeparatedChangeChecker(displayedComponents) ? .main : .secondaryGrayDark)
				.frame(maxWidth: .infinity, alignment: .leading)
				.background(Color.scheme)
				.clipShape(RoundedRectangle(cornerRadius: Constants.Radius.small))
				.allowsHitTesting(false)
		})
    }
}


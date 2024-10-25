//
//  AddNewMeasurementScreen.swift
//  Blood pressure level
//
//  Created by mix on 24.10.2024.
//

import SwiftUI

struct AddNewMeasurementScreen: View {
	
	@State var date = Date()
	@State var systolicTextFieeld = ""
	@State var diastolicTextFieeld = ""
	@State var pulseTextFieeld = ""
	@State var noteTextFieeld = ""
	var cantBeSaved: Bool {
		!systolicTextFieeld.isEmpty && !diastolicTextFieeld.isEmpty ? false : true 
	}
	
    var body: some View {
		ZStack {
			BackgroundView(backgroundType: .addNewScreen)
			
			VStack(spacing: Constants.Spacing.defaultSpacing) {
				
				AddNewHeaderView()

				MainFieldsView(systolicTextFieeld: $systolicTextFieeld,
							   diastolicTextFieeld: $diastolicTextFieeld,
							   pulseTextFieeld: $pulseTextFieeld)

				DateFields(date: $date)
				
				VStack(alignment: .leading) {
					Text("note".localized)
						.font(.system(size: Constants.FontSize.regular))
					
					TextFieldView(placeholder: "describe_your_condition".localized, text: $noteTextFieeld)
				}
				
				Spacer()
				
				AddNewButtonView(cantBeSaved: cantBeSaved)
				
			}
			.padding()
		}
    }
}

#Preview {
    AddNewMeasurementScreen()
}

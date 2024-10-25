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
			
			VStack(spacing: 24) {
				
				AddNewHeaderView()
				
				HStack(alignment: .top, spacing: 24) {

					VStack(alignment: .leading) {
						Text("Кровянное давление")
							.font(.system(size: 16))
						
						HStack(spacing: 8) {
							VStack(alignment: .leading, spacing: 8) {
								Text("Систолическое")
									.font(.system(size: 12))
									.foregroundStyle(.main.opacity(0.5))
								
								TextFieldView(placeholder: "120", text: $systolicTextFieeld)
								
							}
							
							VStack(alignment: .leading, spacing: 8) {
								Text("Диастолическое")
									.font(.system(size: 12))
									.foregroundStyle(.main.opacity(0.5))
								
								TextFieldView(placeholder: "90", text: $diastolicTextFieeld)

							}
						}
					}
					.frame(width: 214, height: 89)
					
					VStack(alignment: .leading)   { 
						Text("Пульс")
							.font(.system(size: 16))
						
						Spacer()
						
						TextFieldView(placeholder: "70", text: $pulseTextFieeld)

					}
				}
				.frame(maxHeight: 90)
				
				HStack {
					VStack(alignment: .leading)  {
						Text("Дата измерений")
							.font(.system(size: 16))
						
						DateFieldView(displayedComponents: .date, date: $date)

					}
					
					VStack(alignment: .leading) {
						Text("Время измерений")
							.font(.system(size: 16))
						
						DateFieldView(displayedComponents: .hourAndMinute, date: $date)
						
					}
				}
				
				VStack(alignment: .leading) {
					Text("Заметка")
						.font(.system(size: 16))
					
					TextFieldView(placeholder: "Опиши свое самочуствие", text: $noteTextFieeld)
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

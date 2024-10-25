//
//  AddNewMeasurementScreen.swift
//  Blood pressure level
//
//  Created by mix on 24.10.2024.
//

import SwiftUI

struct AddNewMeasurementScreen: View {

	@State var date = Date()
	@Environment(\.dismiss) var dismiss
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
				ZStack { 
					Button {
						dismiss()
					} label: {
						RoundedRectangle(cornerRadius: 10)
							.fill(.scheme)
							.frame(width: 32, height: 32)
							.overlay(Image(systemName: "chevron.backward"))
					}
					.foregroundStyle(.main)
					.frame(maxWidth: .infinity, alignment: .leading)
					
					Text("Добавить данные")
						.font(.system(size: 18))
						.bold()
						.frame(maxWidth: .infinity, alignment: .center)
					
				}
				
				HStack(alignment: .top, spacing: 24) {

					VStack(alignment: .leading) {
						Text("Кровянное давление")
							.font(.system(size: 16))
						
						HStack(spacing: 8) {
							VStack(alignment: .leading, spacing: 8) {
								Text("Систолическое")
									.font(.system(size: 12))
									.foregroundStyle(.main.opacity(0.5))
								
								TextField("", text: $systolicTextFieeld)
									.font(.system(size: 18))
									.padding()
									.background(Color.scheme)
									.clipShape(RoundedRectangle(cornerRadius: 14))
									.placeholder(when: systolicTextFieeld.isEmpty) { Text("120") }
							}
							
							VStack(alignment: .leading, spacing: 8) {
								Text("Диастолическое")
									.font(.system(size: 12))
									.foregroundStyle(.main.opacity(0.5))
								
								TextField("", text: $diastolicTextFieeld)
									.font(.system(size: 18))
									.padding()
									.background(Color.scheme)
									.clipShape(RoundedRectangle(cornerRadius: 14))
									.placeholder(when: diastolicTextFieeld.isEmpty) { Text("90") }
							}
						}
					}
					.frame(width: 214, height: 89)
					
					VStack(alignment: .leading)   { 
						Text("Пульс")
							.font(.system(size: 16))
						
						Spacer()
						
						TextField("", text: $pulseTextFieeld)
							.font(.system(size: 18))
							.padding()
							.background(Color.scheme)
							.clipShape(RoundedRectangle(cornerRadius: 14))
							.placeholder(when: pulseTextFieeld.isEmpty) { Text("70") }
					}
				}
				.frame(maxHeight: 90)
				
				HStack {
					VStack(alignment: .leading)  {
						Text("Дата измерений")
							.font(.system(size: 16))
						ZStack(alignment: .leading, content: {
							DatePicker("", selection: $date, in: Date()..., displayedComponents: .date)
							.datePickerStyle(.compact)
							.fixedSize()
							
							let formattedDate = date.formatted(date: .numeric, time: .omitted)
							
							Text(formattedDate)
								.font(.system(size: 18))
								.padding()
								.foregroundStyle(.secondaryGrayDark)
								.frame(maxWidth: .infinity, alignment: .leading)
								.background(Color.scheme)
								.clipShape(RoundedRectangle(cornerRadius: 14))
								.allowsHitTesting(false)
						})
					}
					
					VStack(alignment: .leading) {
						Text("Время измерений")
							.font(.system(size: 16))
						ZStack(alignment: .leading, content: {
							DatePicker("", selection: $date, in: Date()..., displayedComponents: .hourAndMinute)
							.datePickerStyle(.compact)
							.fixedSize()
							
							let formattedDate = date.formatted(.dateTime.hour().minute())
							
							Text(formattedDate)
								.font(.system(size: 18))
								.padding()
								.foregroundStyle(.secondaryGrayDark)
								.frame(maxWidth: .infinity, alignment: .leading)
								.background(Color.scheme)
								.clipShape(RoundedRectangle(cornerRadius: 14))
								.allowsHitTesting(false)
						})
						
					}
				}
				
				VStack(alignment: .leading) {
					Text("Заметка")
						.font(.system(size: 16))
					
					TextField("", text: $noteTextFieeld)
						.placeholder(when: noteTextFieeld.isEmpty) {
										Text("Опиши свое самочуствие")	
									}
						.font(.system(size: 18))
						.padding(.vertical)
						.background(Color.scheme)
						.clipShape(RoundedRectangle(cornerRadius: 14))
						
				}
				
				Spacer()
				Button {
					dismiss()
				} label: {
					Text("Сохранить")
						.frame(maxWidth: .infinity)
				}
				.buttonStyle(BorderedProminentButtonStyle())
				.clipShape(RoundedRectangle(cornerRadius: 14))
				.disabled(cantBeSaved)
			}
			.padding()
		}
    }
}

#Preview {
    AddNewMeasurementScreen()
}

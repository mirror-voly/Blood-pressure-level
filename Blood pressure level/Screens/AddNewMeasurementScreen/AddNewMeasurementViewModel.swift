//
//  AddNewMeasurementViewModel.swift
//  Blood pressure level
//
//  Created by mix on 26.10.2024.
//

import SwiftUI

final class AddNewMeasurementViewModel: ObservableObject {
	
	let dataStore: DataStore
	let currentDate = Date()
	let measurementID = UUID()
	@Published var date = Date()
	@Published var systolicText = ""
	@Published var diastolicText = ""
	@Published var pulseText = ""
	@Published var noteTextFieeld = ""
	
	var cantBeSaved: Bool {
		!systolicText.isEmpty && !diastolicText.isEmpty ? false : true 
	}
	
	func didChange(displayedComponents: DatePickerComponents) -> Bool {
		if displayedComponents == .hourAndMinute {
			return date.formatted(.dateTime.hour().minute()) != currentDate.formatted(.dateTime.hour().minute())
		} else {
			return date.formatted(.dateTime.year().month().day()) != currentDate.formatted(.dateTime.year().month().day())
		}
	}
	
	func takeDate(displayedComponents: DatePickerComponents) -> String {
		let formattedDate: String
		if displayedComponents == .hourAndMinute {
			formattedDate = date.formatted(.dateTime.hour().minute())
		} else {
			formattedDate = date.formatted(date: .numeric, time: .omitted)
		}
		return formattedDate
	}
	
	func saveMeasurement() {
//		let measurement = Measurement(id: measurementID, systolicLevel: systolicTextFieeld, diastolicLevel: <#T##Int#>, date: <#T##Date#>, pulse: <#T##Int?#>, note: <#T##String?#>)
	}
	
	init(dataStore: DataStore) {
		self.dataStore = dataStore
	}
}

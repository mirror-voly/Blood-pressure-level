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
	
	@Published var date = Date() {
		didSet {
			checkIsMeasurementCanBeSaved()
		}
	}
	@Published var systolicText = "" {
		didSet {
			checkIsMeasurementCanBeSaved()
		}
	}
	@Published var diastolicText = "" {
		didSet {
			checkIsMeasurementCanBeSaved()
		}
	}
	@Published var pulseText = "" {
		didSet {
			checkIsMeasurementCanBeSaved()
		}
	}
	@Published var noteText = "" {
		didSet {
			checkIsMeasurementCanBeSaved()
		}
	}
	
	@Published private (set) var canNotBeSaved = true
	
	func checkIsMeasurementCanBeSaved() {
		canNotBeSaved = !systolicText.isEmpty && !diastolicText.isEmpty ? false : true 
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
	
	func makeInt(_ text: String) -> Int? {
		guard let number = Int(text) else { return nil }
		return number
	}
	
	func buttonAction() {
		guard let systolicLevel = makeInt(systolicText), let diastolicLevel = makeInt(diastolicText) else { return }
		let measurement = Measurement(id: measurementID, systolicLevel: systolicLevel, diastolicLevel: diastolicLevel, date: date, pulse: makeInt(pulseText), note: noteText)
		
		dataStore.addOrEditMeasurement(measurement)
		
		canNotBeSaved = true
	}
	
	init(dataStore: DataStore) {
		self.dataStore = dataStore
	}
}

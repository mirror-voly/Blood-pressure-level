//
//  AddNewMeasurementViewModel.swift
//  Blood pressure level
//
//  Created by mix on 26.10.2024.
//

import SwiftUI


final class AddNewMeasurementViewModel: ObservableObject {
	
	private let dataStore: DataStore
	private let measurementID = UUID()
	let currentDate = Date()
	
	@Published var systolicText = Constants.General.emptyString {
		didSet { checkIsMeasurementCanBeSaved() }
	}
	@Published var diastolicText = Constants.General.emptyString  {
		didSet { checkIsMeasurementCanBeSaved() }
	}
	@Published var pulseText = Constants.General.emptyString  {
		didSet { checkIsMeasurementCanBeSaved() }
	}
	@Published var noteText = Constants.General.emptyString  {
		didSet { checkIsMeasurementCanBeSaved() }
	}
	@Published var date = Date() {
		didSet { checkIsMeasurementCanBeSaved() }
	}
	@Published private (set) var canNotBeSaved = true
	//MARK: - Functions
	private func checkIsMeasurementCanBeSaved() {
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
	
	private func makeInt(_ text: String) -> Int? {
		guard let number = Int(text) else { return nil }
		return number
	}
	
	func buttonAction() {
		guard let systolicLevel = makeInt(systolicText), let diastolicLevel = makeInt(diastolicText) else { return }
		let thirtyMinutesBefore = date.addingTimeInterval(-Constants.Time.halfanHour)
		let thirtyMinutesAfter = date.addingTimeInterval(Constants.Time.halfanHour)
		let measurement: Measurement
		let hourIsOccupied = dataStore.measurements.first(where: { measurement in
			return measurement.date >= thirtyMinutesBefore && measurement.date <= thirtyMinutesAfter
		})
		if let id = hourIsOccupied?.id {
			measurement = Measurement(
				systolicLevel: systolicLevel,
				diastolicLevel: diastolicLevel,
				id: id,
				date: date,
				pulse: makeInt(pulseText),
				note: noteText.isEmpty ? nil : noteText
			)
		} else {
			measurement = Measurement(
				systolicLevel: systolicLevel,
				diastolicLevel: diastolicLevel,
				id: measurementID,
				date: date,
				pulse: makeInt(pulseText),
				note: noteText.isEmpty ? nil : noteText
				)
		}
		
		
		dataStore.addOrEditMeasurement(measurement)
		
		canNotBeSaved = true
	}

	
	init(dataStore: DataStore) {
		self.dataStore = dataStore
	}
}

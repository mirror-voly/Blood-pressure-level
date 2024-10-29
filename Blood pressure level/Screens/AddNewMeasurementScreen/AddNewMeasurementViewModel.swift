//
//  AddNewMeasurementViewModel.swift
//  Blood pressure level
//
//  Created by mix on 26.10.2024.
//

import SwiftUI


final class AddNewMeasurementViewModel: ObservableObject {
	
	private let dataStore: DataStore
	private let datePrepare: DatePrepare
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
	
	func getDateText(displayedComponents: DatePickerComponents) -> String {
		datePrepare.getFormatedDate(date: date, displayedComponents: displayedComponents)
	}
	
	func datePickerSeparatedChangeChecker(_ displayedComponents: DatePickerComponents) -> Bool {
		if displayedComponents == .hourAndMinute {
			return date.formatted(.dateTime.hour().minute()) != currentDate.formatted(.dateTime.hour().minute())
		} else {
			return date.formatted(.dateTime.year().month().day()) != currentDate.formatted(.dateTime.year().month().day())
		}
	}
	
	private func checkEditOrAddByTimeInterval() -> UUID? {
		let thirtyMinutesBefore = date.addingTimeInterval(-Constants.Time.halfanHour)
		let thirtyMinutesAfter = date.addingTimeInterval(Constants.Time.halfanHour)
		
		guard let measurement = dataStore.measurements.first(where: { measurement in
			measurement.date >= thirtyMinutesBefore && measurement.date <= thirtyMinutesAfter
		}) else {
			return nil
		}
		return measurement.id
	}

	func buttonAction() {
		guard let systolicLevel = Int(systolicText), let diastolicLevel = Int(diastolicText) else { return }
		let measurementID = checkEditOrAddByTimeInterval() ?? measurementID
		
		let measurement = Measurement(
				systolicLevel: systolicLevel,
				diastolicLevel: diastolicLevel,
				id: measurementID,
				date: date,
				pulse: Int(pulseText),
				note: noteText.isEmpty ? nil : noteText
			)
		dataStore.addOrEditMeasurement(measurement)
		canNotBeSaved = true
	}

	
	init(dataStore: DataStore, datePrepare: DatePrepare) {
		self.dataStore = dataStore
		self.datePrepare = datePrepare
	}
}

//
//  AddNewMeasurementViewModel.swift
//  Blood pressure level
//
//  Created by mix on 26.10.2024.
//

import SwiftUI


final class AddNewMeasurementViewModel: ObservableObject {
	
	private let dataStore: DataStore
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
	
	func getDateFieldViewText(displayedComponents: DatePickerComponents) -> String {
		DatePrepare.getFormatedDate(date: date, displayedComponents: displayedComponents)
	}
	
	func datePickerSeparatedChangeChecker(_ displayedComponents: DatePickerComponents) -> Bool {
		if displayedComponents == .hourAndMinute {
			return date.formatted(.dateTime.hour().minute()) != currentDate.formatted(.dateTime.hour().minute())
		} else {
			return date.formatted(.dateTime.year().month().day()) != currentDate.formatted(.dateTime.year().month().day())
		}
	}
	
	private func checkEditOrAddByTimeInterval() -> UUID? {
		let hourBefore = date.addingTimeInterval(-Constants.Time.hour)
		guard let measurement = dataStore.measurements.first(where: { measurement in
			measurement.date >= hourBefore && measurement.date <= date
		}) else {
			return nil
		}
		return measurement.id
	}

	func buttonAction() {
		guard let systolicLevel = Int(systolicText), let diastolicLevel = Int(diastolicText) else { return }
		let oldMeasurementID = checkEditOrAddByTimeInterval()
		
		let measurement = Measurement(
				systolicLevel: systolicLevel,
				diastolicLevel: diastolicLevel,
				id: oldMeasurementID ?? UUID(),
				date: date,
				pulse: Int(pulseText),
				note: noteText.isEmpty ? nil : noteText
			)
		dataStore.addOrEditMeasurement(measurement, forEdit: oldMeasurementID != nil)
	}

	
	init(dataStore: DataStore) {
		self.dataStore = dataStore
	}
}

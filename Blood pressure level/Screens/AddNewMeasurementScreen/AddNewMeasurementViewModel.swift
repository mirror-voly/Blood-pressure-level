//
//  AddNewMeasurementViewModel.swift
//  Blood pressure level
//
//  Created by mix on 26.10.2024.
//

import SwiftUI
import Combine

final class AddNewMeasurementViewModel: ObservableObject {
	
	let dataStore: DataStore
	let currentDate = Date()
	let measurementID = UUID()
	private var cancellables = Set<AnyCancellable>()
	
	@Published var systolicText = ""
	@Published var diastolicText = ""
	@Published var pulseText = ""
	@Published var noteText = ""
	@Published private (set) var canNotBeSaved = true
	@Published var date = Date() {
		didSet {
			checkIsMeasurementCanBeSaved()
		}
	}
	
	
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
		let measurement = Measurement(systolicLevel: systolicLevel, diastolicLevel: diastolicLevel, id: measurementID, date: date, pulse: makeInt(pulseText), note: noteText)
		
		dataStore.addOrEditMeasurement(measurement)
		
		canNotBeSaved = true
	}
	
	init(dataStore: DataStore) {
		self.dataStore = dataStore
		
		Publishers.MergeMany(
				 $systolicText.removeDuplicates(),
				 $diastolicText.removeDuplicates(),
				 $pulseText.removeDuplicates(),
				 $noteText.removeDuplicates()
			 )
			 .sink { [weak self] _ in
				 self?.checkIsMeasurementCanBeSaved()
			 }
			 .store(in: &cancellables)
		 }
	
}

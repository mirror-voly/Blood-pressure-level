//
//  DataStore.swift
//  Blood pressure level
//
//  Created by mix on 26.10.2024.
//

import SwiftUI
import CoreData

final class DataStore: ObservableObject {
	
	static let shared = DataStore()
	
	@Published private (set) var measurements: [Measurement] = []
	var fetchedResult: FetchedResults<MeasurementData>? {
		didSet {
			updateFetch()
		}
	}
	
	private func updateFetch() {
		guard let fetchedResult = fetchedResult else { return }
		var measurements: [Measurement] = []
		
		for result in fetchedResult {
			let measurement = Measurement(
				systolicLevel: Int(result.systolicLevel),
				diastolicLevel: Int(result.diastolicLevel),
				id: result.id ?? UUID(),
				date: result.date ?? Date(),
				pulse: result.pulse == 0 ? nil : Int(result.pulse),
				note: result.note == Constants.General.emptyString ? nil : result.note
			)
			measurements.append(measurement)
		}
		self.measurements = measurements
	}

	func addOrEditMeasurement(_ measurement: Measurement) {
		if let index = measurements.firstIndex(where: { $0.id == measurement.id }) {
			measurements[index] = measurement
			PersistenceController.convertAndEdit(measurement) 
		} else {
			measurements.append(measurement)
			PersistenceController.convertAndSave(measurement)
		}
		
	}
	
	private init() {}
}

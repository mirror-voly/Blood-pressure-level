//
//  DataStore.swift
//  Blood pressure level
//
//  Created by mix on 26.10.2024.
//

import Foundation
import CoreData

final class DataStore: ObservableObject {
	static let shared = DataStore()
	weak var context: NSManagedObjectContext?
	
	@Published private (set) var measurements: [Measurement] = [
		Measurement(systolicLevel: 170,
					diastolicLevel: 120,
					id: UUID(),
					date: Date().advanced(by: TimeInterval(integerLiteral: Int64(10*18000))),
					pulse: 55,
					note: "oke")
	]
	
	func addOrEditMeasurement(_ measurement: Measurement) {
		if let index = measurements.firstIndex(where: { $0.id == measurement.id }) {
			measurements[index] = measurement
		} else {
			measurements.append(measurement)
		}
		PersistenceController.convertAndSaveAllMeasurements(measurement: measurements)
	}
	
	private init() {

	}
}

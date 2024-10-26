//
//  DataStore.swift
//  Blood pressure level
//
//  Created by mix on 26.10.2024.
//

import Foundation

final class DataStore: ObservableObject {
	static let shared = DataStore()
	
	@Published private (set) var measurements: [Measurement] = []
	
	func addOrEditMeasurement(_ measurement: Measurement) {
		if let index = measurements.firstIndex(where: { $0.id == measurement.id }) {
			measurements[index] = measurement
		} else {
			measurements.append(measurement)
		}
	}
	
	private init() {}
}

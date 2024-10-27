//
//  DataStore.swift
//  Blood pressure level
//
//  Created by mix on 26.10.2024.
//

import Foundation

final class DataStore: ObservableObject {
	static let shared = DataStore()
	
	@Published private (set) var measurements: [Measurement] = [
		Measurement(systolicLevel: 170,
					diastolicLevel: 120,
					id: UUID(),
					date: Date().advanced(by: TimeInterval(integerLiteral: Int64(10*18000))),
					pulse: 55,
					note: "oke"),
		Measurement(systolicLevel: 160,
					diastolicLevel: 110,
					id: UUID(),
					date: Date().advanced(by: TimeInterval(integerLiteral: Int64(50*18000))),
					pulse: 55,
					note: "oke"),
		Measurement(systolicLevel: 140,
					diastolicLevel: 100,
					id: UUID(),
					date: Date().advanced(by: TimeInterval(integerLiteral: Int64(57*18000))),
					pulse: 55,
					note: "oke"),
		Measurement(systolicLevel: 148,
					diastolicLevel: 90,
					id: UUID(),
					date: Date().advanced(by: TimeInterval(integerLiteral: Int64(65*18000))),
					pulse: 55,
					note: "oke"),
		Measurement(systolicLevel: 110,
					diastolicLevel: 85,
					id: UUID(),
					date: Date().advanced(by: TimeInterval(integerLiteral: Int64(90*18000))),
					pulse: 55,
					note: "oke"),
	
	]
	
	func addOrEditMeasurement(_ measurement: Measurement) {
		if let index = measurements.firstIndex(where: { $0.id == measurement.id }) {
			measurements[index] = measurement
		} else {
			measurements.append(measurement)
		}
	}
	
	private init() {
		
		for i in 0...2 {
			let randomNumber = (30...150).randomElement()
			
			measurements.append(Measurement(systolicLevel: randomNumber! + 50, diastolicLevel: randomNumber!, id: UUID(), date: Date().advanced(by: TimeInterval(integerLiteral: Int64(i*18000))), pulse: randomNumber, note: "oke"))
		}
			
		
	}
}

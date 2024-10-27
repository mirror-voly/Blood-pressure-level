//
//  Measurement.swift
//  Blood pressure level
//
//  Created by mix on 25.10.2024.
//

import Foundation

final class Measurement: Identifiable {
	let id: UUID
	let pressure: Pressure
	let date: Date
	let pulse: Int?
	let note: String?
	
	init(id: UUID, pressure: Pressure, date: Date, pulse: Int?, note: String?) {
		self.id = id
		self.pressure = pressure
		self.date = date
		self.pulse = pulse
		self.note = note
	}
	
}

class Pressure {

	let systolicLevel: Int
	let diastolicLevel: Int
	
	init(systolicLevel: Int, diastolicLevel: Int) {
		self.systolicLevel = systolicLevel
		self.diastolicLevel = diastolicLevel
	}
}

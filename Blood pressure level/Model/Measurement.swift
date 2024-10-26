//
//  Measurement.swift
//  Blood pressure level
//
//  Created by mix on 25.10.2024.
//

import Foundation

final class Measurement {
	let id: UUID
	let systolicLevel: Int
	let diastolicLevel: Int
	let date: Date
	let pulse: Int?
	let note: String?

	init(id: UUID, systolicLevel: Int, diastolicLevel: Int, date: Date, pulse: Int?, note: String?) {
		self.id = id
		self.systolicLevel = systolicLevel
		self.diastolicLevel = diastolicLevel
		self.date = date
		self.pulse = pulse
		self.note = note
	}
}

//
//  Measurement.swift
//  Blood pressure level
//
//  Created by mix on 25.10.2024.
//

import Foundation

final class Measurement: Identifiable {
	let id: UUID
	let systolicLevel: Int
	let diastolicLevel: Int
	let date: Date
	let pulse: Int?
	let note: String?
	
	init(systolicLevel: Int, diastolicLevel: Int, id: UUID, date: Date, pulse: Int?, note: String?) {
		self.id = id
		self.date = date
		self.pulse = pulse
		self.note = note
		self.systolicLevel = systolicLevel
		self.diastolicLevel = diastolicLevel
	}
	
}

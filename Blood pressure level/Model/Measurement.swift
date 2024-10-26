//
//  Measurement.swift
//  Blood pressure level
//
//  Created by mix on 25.10.2024.
//

import Foundation

final class Measurement {
	private let id = UUID()
	private let systolicLevel: Int
	private let diastolicLevel: Int
	private let date: Date
	private let pulse: Int?
	private let note: String?

	init(systolicLevel: Int, diastolicLevel: Int, pulse: Int, date: Date, note: String) {
		self.systolicLevel = systolicLevel
		self.diastolicLevel = diastolicLevel
		self.pulse = pulse
		self.date = date
		self.note = note
	}
}

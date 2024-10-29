//
//  SelectedMeasurementsInfo.swift
//  Blood pressure level
//
//  Created by mix on 29.10.2024.
//

import Foundation

final class SelectedMeasurementsInfo {
	let systolicLevelsMax: Int
	let systolicLevelsMin: Int?
	let diastolicLevelMax: Int
	let diastolicLevelMin: Int?
	let pulseMax: Int?
	let pulseMin: Int?
	let note: [(time: String, text: String)?]
	let date: Date
	
	init(systolicLevelsMax: Int, systolicLevelsMin: Int?, diastolicLevelMax: Int, diastolicLevelMin: Int?, pulseMax: Int?, pulseMin: Int?, note: [(time: String, text: String)?], date: Date) {
		self.systolicLevelsMax = systolicLevelsMax
		self.systolicLevelsMin = systolicLevelsMin
		self.diastolicLevelMax = diastolicLevelMax
		self.diastolicLevelMin = diastolicLevelMin
		self.pulseMax = pulseMax
		self.pulseMin = pulseMin
		self.note = note
		self.date = date
	}
}

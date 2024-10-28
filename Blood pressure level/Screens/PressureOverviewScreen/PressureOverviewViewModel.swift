//
//  PressureOverviewViewModel.swift
//  Blood pressure level
//
//  Created by mix on 25.10.2024.
//

import SwiftUI
import Charts
//import RxSwift
//import RxCocoa

final class PressureOverviewViewModel: ObservableObject {
	
	@Published var period: PresentationPeriod = .day
	@Published var tipIsActive = false
	@Published var addNewScreenIsPresented = false
	
	let dataStore: DataStore
	let formattedDate: String
	private let formatter = DateFormatter()
	private let calendar = Calendar.current
	private let currentDate: Date
	
	var periodInfo: String {
		let date = getTimeInterval() 
		let start = date.startOfPeriod.formatted(.dateTime.month().day())
		let end = date.endOfPeriod.formatted(.dateTime.month().day())
		return "\(start)-\(end)"
	}
	var filteredMeasurementsForPresentationPeriod: [Measurement] {
		getMeasurementsForPresentationPeriod()
	}
	var measurementsWithNotes: [Measurement] {
		filteredMeasurementsForPresentationPeriod.filter({ $0.note != nil })
	}
	var firstNoteInfo: (time: String, text: String) {
		guard let first = measurementsWithNotes.first, let note = first.note else { return ("","")}
		formatter.dateFormat = "d.MM H:mm"
		return (formatter.string(from: first.date), note)
	}
	var timeInterval: (startOfPeriod: Date, endOfPeriod: Date) {
		getTimeInterval()
	}
	var minAndMaxPressureLevelInfo: String? {
		guard let info = getMinAndMaxPressureLevel() else { return nil }
		if let diastolicMin = info.diastolic.min, let systolicMin = info.systolic.min {
			return "\(info.diastolic.max) - \(info.systolic.max) / \(diastolicMin) - \(systolicMin)"
		} else {
			return "\(info.diastolic.max) - \(info.systolic.max)"
		}
	}
	var minAndMaxPulseLevelInfo: String? {
		guard let pulse = getMinAndMaxPulseLevel() else { return nil }
		if let min = pulse.min, min != pulse.max {
			return "\(pulse.max) - \(min)"
		} else {
			return "\(pulse.max)"
		}
	}
	var calendarComponentForPeriod: Calendar.Component {
		switch period {
			case .day:
					.hour
			case .week:
					.day
			case .month:
					.day
		}
	}
	//MARK: Functions
	private func sortByDate(measurements: [Measurement]) -> [Measurement] {
		measurements.sorted(by: { $0.date > $1.date	})
	}
	
	private func sortAndAverageMeasurements(measurements: [Measurement]) -> [Measurement] {
		var groupedMeasurements: [Date: [Measurement]] = [:]
		
		for measurement in measurements {
			let dateKey = Calendar.current.startOfDay(for: measurement.date)
			groupedMeasurements[dateKey, default: []].append(measurement)
		}
		
		var averagedMeasurements: [Measurement] = []
		
		for (_, group) in groupedMeasurements {
			if !group.isEmpty {
				let averageSystolic = group.map { $0.systolicLevel }.reduce(0, +) / group.count
				let averageDiastolic = group.map { $0.diastolicLevel }.reduce(0, +) / group.count
				let averagePulse = group.compactMap { $0.pulse }.reduce(0, +) / group.count
				
				// Создаем новое измерение с усредненными значениями
				let averagedMeasurement = Measurement(systolicLevel: averageSystolic, diastolicLevel: averageDiastolic, id: UUID(), date: group[0].date, pulse: averagePulse, note: nil)
				
				averagedMeasurements.append(averagedMeasurement)
			}
		}
		let sortedMeasurements = sortByDate(measurements: averagedMeasurements)
		
		return sortedMeasurements
	}

	
	func getTimeInterval() -> (startOfPeriod: Date, endOfPeriod: Date) {
		let start: Date
		let end: Date
		
		switch period {
			case .day:
				start = calendar.startOfDay(for: currentDate)
				end = start.addingTimeInterval(86400)
				return (startOfPeriod: start, endOfPeriod: end)
				
			case .week:
				if let startDate = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentDate)) {
					start = startDate
					let days = calendar.date(byAdding: .day, value: 6, to: start) ?? start
					end = days.addingTimeInterval(86399)
					return (startOfPeriod: start, endOfPeriod: end)
				}
				
			case .month:
				if let end = calendar.date(from: calendar.dateComponents([.year, .month, .day], from: currentDate)) {
					start = calendar.date(byAdding: .day, value: -30, to: end) ?? end
					return (startOfPeriod: start, endOfPeriod: end)
				}
		}
		
		return (startOfPeriod: currentDate, endOfPeriod: currentDate)
	}


	private func getMeasurementsForPresentationPeriod() -> [Measurement] {
		let (startOfPeriod, endOfPeriod) = getTimeInterval()
		
		let filtered = dataStore.measurements.filter { measurement in
			return measurement.date >= startOfPeriod && measurement.date < endOfPeriod
		}
		
		return period == .day ? sortByDate(measurements: filtered) : sortAndAverageMeasurements(measurements: filtered)
	}

	func formatDate(for date: Date) -> String {
		switch period {
		case .day:
			formatter.dateFormat = "H"
		case .week, .month:
			formatter.dateFormat = "d.MM"
		}
		return formatter.string(from: date)
	}
	
	func getAxisValues() -> AxisMarkValues {
		switch period {
			case .day:
				return .automatic(desiredCount: 5)
			case .week:
				return .automatic(desiredCount: 7)
			case .month:
				return .stride(by: .day, count: 5)
		}
	}

	func getMinAndMaxPressureLevel() -> (systolic: (max: Int, min: Int?), diastolic: (max: Int, min: Int?))? {
		guard !filteredMeasurementsForPresentationPeriod.isEmpty else { return nil }
		
		let systolic: (Int, Int?)
		let diastolic: (Int, Int?)
		
		switch filteredMeasurementsForPresentationPeriod.count {
		case 1:
			let first = filteredMeasurementsForPresentationPeriod[0]
				systolic = (first.systolicLevel, nil)
				diastolic = (first.diastolicLevel, nil)
		case let count where count > 1:
			let systolicLevels = filteredMeasurementsForPresentationPeriod.map { $0.systolicLevel }
			let diastolicLevels = filteredMeasurementsForPresentationPeriod.map { $0.diastolicLevel }
			guard let maxSystolic = systolicLevels.max(),
				  let minSystolic = systolicLevels.min(),
				  let maxDiastolic = diastolicLevels.max(),
				  let minDiastolic = diastolicLevels.min() else {
				return nil
			}
				systolic = (maxSystolic, minSystolic)
				diastolic = (maxDiastolic, minDiastolic)
		default:
			return nil
		}
		return (systolic, diastolic)
	}
	
	func getMinAndMaxPulseLevel() -> (max: Int, min: Int?)? {
		guard !filteredMeasurementsForPresentationPeriod.isEmpty else { return nil }
		let pulseInfo: (Int, Int?)?
		switch filteredMeasurementsForPresentationPeriod.count {
			case 1:
				let first = filteredMeasurementsForPresentationPeriod[0]
				if let pulse = first.pulse.map({ Int($0) }) {
					pulseInfo = (pulse, nil)
				} else {
					pulseInfo = nil
				}
			case let count where count > 1:
				let pulses = filteredMeasurementsForPresentationPeriod.compactMap { $0.pulse }
				guard let biggestPulse = pulses.max(), let smallestPulse = pulses.min() else { return nil }
				pulseInfo = (smallestPulse, biggestPulse)
			default:
				return nil
		}

		return pulseInfo
	}
	
	init(dataStore: DataStore) {
		self.dataStore = dataStore
		self.formattedDate = Date.now.formatted(.dateTime.month().year())
		self.currentDate = Date()
	}
	
}

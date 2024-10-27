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
	var timeInterval: (startOfPeriod: Date, endOfPeriod: Date) {
		getTimeInterval()
	}
	var minAndMaxLevelInfo: (pressureInfo: String, pulseInfo: String?)? {
		getMinAndMaxLevelInfo()
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
	
	private func sortByDate(measurements: [Measurement]) -> [Measurement] {
		measurements.sorted(by: { $0.date > $1.date	})
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
					start = calendar.date(byAdding: .month, value: -1, to: end) ?? end
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
		
		return sortByDate(measurements: filtered)
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

	func getMinAndMaxLevelInfo() -> (pressureInfo: String, pulseInfo: String?)? {
		guard !filteredMeasurementsForPresentationPeriod.isEmpty else { return nil }
		
		let pressureInfo: String
		let pulseInfo: String?
		
		switch filteredMeasurementsForPresentationPeriod.count {
		case 1:
			let first = filteredMeasurementsForPresentationPeriod[0]
			pressureInfo = "\(first.systolicLevel) - \(first.diastolicLevel)"
			pulseInfo = first.pulse.map { String($0) }
		case let count where count > 1:
			let systolicLevels = filteredMeasurementsForPresentationPeriod.map { $0.systolicLevel }
			let diastolicLevels = filteredMeasurementsForPresentationPeriod.compactMap { $0.diastolicLevel }
			guard let maxSystolic = systolicLevels.max(),
				  let minSystolic = systolicLevels.min(),
				  let maxDiastolic = diastolicLevels.max(),
				  let minDiastolic = diastolicLevels.min() else {
				return nil
			}
			pressureInfo = "\(maxSystolic) - \(maxDiastolic) / \(minSystolic) - \(minDiastolic)"
			let pulses = filteredMeasurementsForPresentationPeriod.compactMap { $0.pulse }
			guard let biggestPulse = pulses.max(), let smallestPulse = pulses.min() else {
				pulseInfo = nil
				break
			}
			pulseInfo = (smallestPulse != biggestPulse) ? "\(smallestPulse)-\(biggestPulse)" : "\(biggestPulse)"
		default:
			return nil
		}
		
		return (pressureInfo, pulseInfo)
	}
	
	init(dataStore: DataStore) {
		self.dataStore = dataStore
		self.formattedDate = Date.now.formatted(.dateTime.month().year())
		self.currentDate = Date()
	}
	
}

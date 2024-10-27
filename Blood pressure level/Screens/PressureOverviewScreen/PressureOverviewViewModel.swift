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
	
	let dataStore: DataStore
	let formattedDate: String
	private let formatter = DateFormatter()
	private let calendar = Calendar.current
	private let currentDate: Date
	
	@Published var period: PresentationPeriod = .day
	@Published var tipIsActive = false
	@Published var addNewScreenIsPresented = false

	var timeInterval: (startOfPeriod: Date, endOfPeriod: Date) {
		getTimeInterval()
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
	
	func sortByDate(measurements: [Measurement]) -> [Measurement] {
		measurements.sorted(by: { $0.date > $1.date	})
	}
	
	func getTimeInterval() -> (startOfPeriod: Date, endOfPeriod: Date) {
		let start: Date
		let end: Date
		
		switch period {
		case .day:
			start = calendar.startOfDay(for: currentDate)
			end = start.addingTimeInterval(86400)
		case .week:
			start = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentDate))!
			end = calendar.date(byAdding: .day, value: 7, to: start)!
		case .month:
			start = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate))!
			end = calendar.date(byAdding: .month, value: 1, to: start)!
		}
		
		return (startOfPeriod: start, endOfPeriod: end)
	}

	func getMeasurementsForPresentationPeriod() -> [Measurement] {
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
				return .automatic(desiredCount: 5, roundLowerBound: true, roundUpperBound: true)
			case .week:
				return .automatic(desiredCount: 7)
			case .month:
				return .automatic(desiredCount: 7, roundLowerBound: true, roundUpperBound: true)
		}
	}

	init(dataStore: DataStore) {
		self.dataStore = dataStore
		self.formattedDate = Date.now.formatted(.dateTime.month().year())
		self.currentDate = Date()
	}
	
}

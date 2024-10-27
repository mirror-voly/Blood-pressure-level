//
//  PressureOverviewViewModel.swift
//  Blood pressure level
//
//  Created by mix on 25.10.2024.
//

import SwiftUI
import RxSwift
import RxCocoa

final class PressureOverviewViewModel: ObservableObject {
	
	let dataStore: DataStore
	@Published var formattedDate = Date.now.formatted(.dateTime.month().year())
	
	@Published var period: PresentationPeriod = .day
	@Published var tipIsActive = false
	@Published var addNewScreenIsPresented = false
	
	func getMeasurementsForPresentationPeriod() -> [Measurement] {
		let calendar = Calendar.current
		let now = Date()
		
		switch period {
		case .day:
			let startOfDay = calendar.startOfDay(for: now)
			return dataStore.measurements.filter { measurement in
				let measurementDate = calendar.startOfDay(for: measurement.date)
				return measurementDate == startOfDay
			}
			
		case .week:
			let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: now))!
			let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek)!
			return dataStore.measurements.filter { measurement in
				return measurement.date >= startOfWeek && measurement.date <= endOfWeek
			}
			
		case .month:
			let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: now))!
			let endOfMonth = calendar.date(byAdding: .month, value: 1, to: startOfMonth)!
			return dataStore.measurements.filter { measurement in
				return measurement.date >= startOfMonth && measurement.date < endOfMonth
			}
		}
	}
	
	init(dataStore: DataStore) {
		self.dataStore = dataStore
	}
	
}

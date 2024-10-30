//
//  DateCalculator.swift
//  Blood pressure level
//
//  Created by mix on 30.10.2024.
//

import Foundation

/// Класс `DateCalculator` предоставляет методы для вычисления временных интервалов
/// на основе заданного периода и текущей даты.
final class DateCalculator {
	
	/// Текущий календарь, используемый для вычислений.
	private let calendar = Calendar.current
	
	/// Возвращает начальную и конечную даты для заданного периода.
	///
	/// - Parameters:
	///   - period: Период, для которого нужно вычислить временной интервал.
	///   - currentDate: Текущая дата, от которой будет производиться расчет.
	/// - Returns: Кортеж, содержащий начальную и конечную даты периода.
	func getTimeInterval(period: PresentationPeriod, currentDate: Date) -> (startOfPeriod: Date, endOfPeriod: Date) {
		let start: Date
		let end: Date
		
		switch period {
			case .day:
				// Для дневного периода устанавливаем начало дня и конец через 24 часа.
				start = calendar.startOfDay(for: currentDate)
				end = start.addingTimeInterval(Constants.Time.day)
				return (startOfPeriod: start, endOfPeriod: end)
				
			case .week:
				// Для недельного периода вычисляем начало недели и конец через 7 дней.
				if let startDate = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear],
																			   from: currentDate)) {
					start = startDate
					let end = calendar.date(byAdding: .day, value: 7, to: start) ?? start
					return (startOfPeriod: start, endOfPeriod: end)
				}
				
			case .month:
				// Для месячного периода вычисляем начало месяца и конец через 30 дней.
				if let end = calendar.date(from: calendar.dateComponents([.year, .month, .day],
									from: currentDate.addingTimeInterval(Constants.Time.day * 2))) {
					start = calendar.date(byAdding: .day, value: -30, to: end) ?? end
					return (startOfPeriod: start, endOfPeriod: end)
				}
		}
		// Возвращаем текущую дату, если период не распознан.
		return (startOfPeriod: currentDate, endOfPeriod: currentDate)
	}
}

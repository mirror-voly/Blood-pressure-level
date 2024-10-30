//
//  DatePrepare.swift
//  Blood pressure level
//
//  Created by mix on 29.10.2024.
//

import SwiftUI

/// Утилита для форматирования и представления дат.
final class DatePresenter {
	
	/// Форматирует дату в строку в зависимости от отображаемых компонентов.
	/// - Parameters:
	///   - date: Дата, которую нужно отформатировать.
	///   - displayedComponents: Компоненты даты, которые нужно отобразить (часы и минуты или только дата).
	/// - Returns: Отформатированная строка даты.
	static func getFormatedDate(date: Date, displayedComponents: DatePickerComponents) -> String {
		let formattedDate: String
		if displayedComponents == .hourAndMinute {
			formattedDate = date.formatted(.dateTime.hour().minute())
		} else {
			formattedDate = date.formatted(date: .numeric, time: .omitted)
		}
		return formattedDate
	}
	
	/// Получает текст для отображения даты в зависимости от стиля форматирования.
	/// - Parameters:
	///   - date: Дата, которую нужно отобразить.
	///   - formatStyle: Стиль форматирования (день, неделя, месяц).
	/// - Returns: Отформатированная строка даты.
	static func getOverlayDateText(date: Date, formatStyle: PresentationPeriod) -> String {
		if formatStyle == .day {
			return date.formatted(.dateTime.hour().minute()).localizedCapitalized
		} else {
			return date.formatted(.dateTime.year().month().day()).localizedCapitalized
		}
	}
	
	/// Форматирует строку, представляющую начальную и конечную дату периода.
	/// - Parameters:
	///   - startOfPeriod: Начало периода.
	///   - endOfPeriod: Конец периода.
	/// - Returns: Строка, представляющая диапазон дат.
	static func getStartAndEndDateString(startOfPeriod: Date, endOfPeriod: Date) -> String {
		let start = startOfPeriod.formatted(.dateTime.month().day())
		let end = endOfPeriod.formatted(.dateTime.month().day())
		return "\(start)-\(end)"
	}
	
	/// Форматирует дату для оси X графика в зависимости от выбранного периода.
	/// - Parameters:
	///   - period: Период, для которого нужно отформатировать дату.
	///   - date: Дата, которую нужно отформатировать.
	/// - Returns: Отформатированная строка даты для оси X графика.
	static func formatChartXAxisDateFor(period: PresentationPeriod, date: Date) -> String {
		let formatter = DateFormatter()
		switch period {
		case .day:
			formatter.dateFormat = "H"
		case .week, .month:
			formatter.dateFormat = "d.MM"
		}
		return formatter.string(from: date)
	}
	
	/// Получает текст заметки с датой для заданного измерения.
	/// - Parameters:
	///   - measurement: Измерение, для которого нужно получить текст заметки.
	///   - measurementsWithNote: Массив измерений с заметками.
	/// - Returns: Кортеж с временем и текстом заметки, если они существуют; иначе `nil`.
	static func getNoteWithDateText(measurement: Measurement?, measurementsWithNote: [Measurement]) -> (time: String, text: String)? {
		let formatter = DateFormatter()
		formatter.dateFormat = "d.MM H:mm"
		// Используем переданное измерение или первое измерение из measurementsWithNote
		let targetMeasurement = measurement ?? measurementsWithNote.first
		// Проверяем, есть ли целевое измерение и его заметка
		guard let note = targetMeasurement?.note else { return nil }
		return (formatter.string(from: targetMeasurement!.date), note)
	}
}

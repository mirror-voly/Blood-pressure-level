//
//  AddNewMeasurementViewModel.swift
//  Blood pressure level
//
//  Created by mix on 26.10.2024.
//

import SwiftUI

/// ViewModel для добавления нового измерения давления.
final class AddNewMeasurementViewModel: ObservableObject {
	
	// MARK: - Properties
	
	/// Хранилище данных для хранения измерений.
	private let dataStore: DataStore
	
	/// Текущая дата для отслеживания изменений выборщика даты/
	let currentDate = Date()
	
	/// Текстовое поле для систолического давления.
	@Published var systolicText = Constants.General.emptyString {
		didSet { checkIsMeasurementCanBeSaved() }
	}
	
	/// Текстовое поле для диастолического давления.
	@Published var diastolicText = Constants.General.emptyString {
		didSet { checkIsMeasurementCanBeSaved() }
	}
	
	/// Текстовое поле для пульса.
	@Published var pulseText = Constants.General.emptyString {
		didSet { checkIsMeasurementCanBeSaved() }
	}
	
	/// Текстовое поле для заметки.
	@Published var noteText = Constants.General.emptyString {
		didSet { checkIsMeasurementCanBeSaved() }
	}
	
	/// Дата измерения.
	@Published var date = Date() {
		didSet { checkIsMeasurementCanBeSaved() }
	}
	
	/// Переключатель для активации кнопки.
	@Published private(set) var canNotBeSaved = true
	
	// MARK: - Functions
	
	/// Проверяет, может ли измерение быть сохранено.
	private func checkIsMeasurementCanBeSaved() {
		canNotBeSaved = systolicText.isEmpty || diastolicText.isEmpty
	}
	
	/// Получает текст для отображения в поле даты.
	/// - Parameter displayedComponents: Компоненты даты, которые нужно отобразить.
	/// - Returns: Отформатированная строка даты.
	func getDateFieldViewText(displayedComponents: DatePickerComponents) -> String {
		DatePresenter.getFormatedDate(date: date, displayedComponents: displayedComponents)
	}
	
	/// Проверяет, изменились ли компоненты даты в селекторе.
	/// - Parameter displayedComponents: Компоненты даты, которые нужно проверить.
	/// - Returns: `true`, если компоненты изменились, иначе `false`.
	func datePickerSeparatedChangeChecker(_ displayedComponents: DatePickerComponents) -> Bool {
		if displayedComponents == .hourAndMinute {
			return date.formatted(.dateTime.hour().minute()) != currentDate.formatted(.dateTime.hour().minute())
		} else {
			return date.formatted(.dateTime.year().month().day()) != currentDate.formatted(.dateTime.year().month().day())
		}
	}
	
	/// Проверяет, нужно ли редактировать или добавлять измерение на основе временного интервала.
	/// - Returns: Идентификатор измерения, если оно существует, иначе `nil`.
	private func checkEditOrAddByTimeInterval() -> UUID? {
		let hourBefore = date.addingTimeInterval(-Constants.Time.hour)
		guard let measurement = dataStore.measurements.first(where: { measurement in
			measurement.date >= hourBefore && measurement.date <= date
		}) else {
			return nil
		}
		return measurement.id
	}

	/// Выполняет действие кнопки для сохранения измерения.
	func buttonAction() {
		guard let systolicLevel = Int(systolicText), let diastolicLevel = Int(diastolicText) else { return }
		let oldMeasurementID = checkEditOrAddByTimeInterval()
		
		let measurement = Measurement(
			systolicLevel: systolicLevel,
			diastolicLevel: diastolicLevel,
			id: oldMeasurementID ?? UUID(),
			date: date,
			pulse: Int(pulseText),
			note: noteText.isEmpty ? nil : noteText
		)
		dataStore.addOrEditMeasurement(measurement, forEdit: oldMeasurementID != nil)
	}

	/// Инициализирует AddNewMeasurementViewModel с заданным хранилищем данных.
	/// - Parameter dataStore: Хранилище данных, содержащее измерения.
	init(dataStore: DataStore) {
		self.dataStore = dataStore
	}
}

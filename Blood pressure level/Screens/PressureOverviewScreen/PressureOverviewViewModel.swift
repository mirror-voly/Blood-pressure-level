//
//  PressureOverviewViewModel.swift
//  Blood pressure level
//
//  Created by mix on 25.10.2024.
//

import SwiftUI
import Charts

/// ViewModel для отображения информации о давлении.
final class PressureOverviewViewModel: ObservableObject {
	
	// MARK: - Published variables
	
	/// Период отображения данных (день, неделя, месяц).
	@Published var period: PresentationPeriod = .day {
		didSet {
			selectedMessurment = nil
		}
	}
	
	/// Активен ли подсказка.
	@Published var tipIsActive = false
	
	/// Признак того, что экран добавления нового измерения представлен.
	@Published var addNewScreenIsPresented = false
	
	/// Выбранная информация о измерении.
	@Published var selectedMessurment: SelectedMeasurementsInfo?
	
	// MARK: - Local constants
	
	/// Отформатированная дата.
	let formattedDate: String
	
	/// Калькулятор для измерений.
	private let measurementsCalculator = MeasurementsCalculator()
	
	/// Калькулятор для дат.
	private let dateCalculator = DateCalculator()
	
	/// Хранилище данных.
	private let dataStore: DataStore
	
	/// Текущая дата.
	private let currentDate: Date
	
	// MARK: - Calculated variables
	
	/// Интервал времени для выбранного периода.
	var timeInterval: (startOfPeriod: Date, endOfPeriod: Date) {
		getTimeInterval()
	}
	
	/// Строка с интервалом дат для выбранного периода.
	var dateIntervalStringForPeriod: String {
		return DatePresenter.getStartAndEndDateString(startOfPeriod: timeInterval.startOfPeriod,
													  endOfPeriod: timeInterval.endOfPeriod)
	}
	
	/// Отфильтрованные измерения для выбранного периода.
	private var filteredMeasurementsForPresentationPeriod: [Measurement] {
		getMeasurementsForPresentationPeriod()
	}
	
	/// Средние измерения для графика.
	var chartAverageMeasurements: [Measurement] {
		period != .day ? getAverageMeasurementsByDays(filteredMeasurementsForPresentationPeriod) : filteredMeasurementsForPresentationPeriod
	}
	
	/// Измерения с заметками.
	var measurementsWithNote: [Measurement] {
		let filteredNotes = filteredMeasurementsForPresentationPeriod.filter({ $0.note != nil })
		return period != .day ? findNotesIn(filteredNotes) : filteredNotes
	}
	
	/// Информация о минимальном и максимальном уровне давления.
	var minAndMaxPressureLevelInfo: String? {
		measurementsCalculator.getMinAndMaxPressureLevelStringResult(filteredMeasurementsForPresentationPeriod)
	}
	
	/// Информация о минимальном и максимальном уровне пульса.
	var minAndMaxPulseLevelInfo: String? {
		measurementsCalculator.getMinAndMaxPulseLevelStringResult(filteredMeasurementsForPresentationPeriod)
	}
	
	/// Единица измерения для графика в зависимости от периода.
	var chartUnitForPeriod: Calendar.Component {
		return period == .day ? .hour : .day
	}
	
	// MARK: - Functions
	
	/// Запускает таймер для отображения подсказки, если это необходимо.
	private func startAlertTimerIfNeeded() {
		guard self.dataStore.measurements.isEmpty else { return }
		DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: { self.tipIsActive = true })
		DispatchQueue.main.asyncAfter(deadline: .now() + 15, execute: { self.tipIsActive = false })
	}
	
	/// Получает интервал времени для выбранного периода.
	func getTimeInterval() -> (startOfPeriod: Date, endOfPeriod: Date) {
		dateCalculator.getTimeInterval(period: period, currentDate: currentDate)
	}
	
	/// Получает значения оси графика.
	func getChartAxisValues() -> AxisMarkValues {
		switch period {
			case .day:
				return .automatic(desiredCount: 5)
			case .week:
				return .automatic(desiredCount: 7)
			case .month:
				return .stride(by: .day, count: 5)
		}
	}
	
	/// Получает текст для отображения даты на графике.
	func getOverlayDateText(date: Date, formatStyle: PresentationPeriod) -> String {
		DatePresenter.getOverlayDateText(date: date, formatStyle: formatStyle)
	}
	
	/// Форматирует дату для оси X графика.
	/// - Parameter date: Дата, которую нужно отформатировать.
	/// - Returns: Отформатированная строка даты.
	func formatChartXAxisDateFor(date: Date) -> String {
		DatePresenter.formatChartXAxisDateFor(period: period, date: date)
	}
	
	/// Получает измерения для выбранного периода.
	/// - Returns: Массив измерений, соответствующих выбранному периоду.
	private func getMeasurementsForPresentationPeriod() -> [Measurement] {
		let (startOfPeriod, endOfPeriod) = getTimeInterval()
		
		return dataStore.measurements.filter { measurement in
			return measurement.date >= startOfPeriod && measurement.date < endOfPeriod
		}
	}
	
	/// Находит и устанавливает выбранное измерение на основе значения по оси X.
	/// - Parameter xValue: Значение по оси X, для которого нужно найти измерение.
	func findAndSetSelection(xValue: Date) {
		let shift = period == .day ? Constants.Time.halfanHour : Constants.Time.halfADay
		let measurements = filteredMeasurementsForPresentationPeriod.filter({ measurement in
			return measurement.date >= xValue.addingTimeInterval(-shift) && measurement.date <= xValue.addingTimeInterval(shift)
		})
		selectedMessurment = getSummaryInfoForSelectedMeasurements(measurements)
	}
	
	/// Получает средние измерения по дням.
	/// - Parameter measurements: Массив измерений для усреднения.
	/// - Returns: Массив средних измерений.
	private func getAverageMeasurementsByDays(_ measurements: [Measurement]) -> [Measurement] {
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
				let notes = group.compactMap { $0.note }
				let averagedMeasurement = Measurement(systolicLevel: averageSystolic, diastolicLevel: averageDiastolic, id: UUID(), date: group[0].date, pulse: nil, note: notes.first)
				averagedMeasurements.append(averagedMeasurement)
			}
		}
		let sortedMeasurements = averagedMeasurements.sorted(by: { $0.date > $1.date })
		return sortedMeasurements
	}
	
	/// Находит измерения с заметками в заданном массиве измерений.
	/// - Parameter measurements: Массив измерений для фильтрации.
	/// - Returns: Массив измерений с заметками.
	func findNotesIn(_ measurements: [Measurement]) -> [Measurement] {
		let chartDates = Set(chartAverageMeasurements.map { Calendar.current.startOfDay(for: $0.date) })
		let measurementsWithNote = measurements.compactMap { item in
			let itemDate = Calendar.current.startOfDay(for: item.date)
			return chartDates.contains(itemDate) ? chartAverageMeasurements.first(where: { Calendar.current.startOfDay(for: $0.date) == itemDate }) : nil
		}
		return measurementsWithNote
	}
	
	/// Получает информацию о заметке и времени для заданного измерения.
	/// - Parameter measurement: Измерение, для которого нужно получить информацию.
	/// - Returns: Кортеж с временем и текстом заметки, если они существуют.
	func getNoteInfo(measurement: Measurement?) -> (time: String, text: String)? {
		DatePresenter.getNoteWithDateText(measurement: measurement, measurementsWithNote: measurementsWithNote)
	}
	
	/// Получает сводную информацию о выбранных измерениях.
	/// - Parameter measurements: Массив измерений для анализа.
	/// - Returns: Сводная информация о измерениях, если они существуют.
	func getSummaryInfoForSelectedMeasurements(_ measurements: [Measurement]) -> SelectedMeasurementsInfo? {
		guard let firstMeasurement = measurements.first else { return nil }
		let systolicLevels = measurements.map { $0.systolicLevel }
		let diastolicLevels = measurements.map { $0.diastolicLevel }
		let pulses = measurements.compactMap { $0.pulse }
		let notes = measurements.filter({ $0.note != nil })
		
		guard let systolicLevelsMax = systolicLevels.max(), let diastolicLevelMax = diastolicLevels.max() else { return nil }
		
		let systolicLevelsMin = systolicLevels.min()
		let diastolicLevelMin = diastolicLevels.min()
		let pulseMax = pulses.max()
		let pulseMin = pulses.min()
		let date = firstMeasurement.date
		let notesInfo = notes.map { getNoteInfo(measurement: $0) }
		
		let info = SelectedMeasurementsInfo(systolicLevelsMax: systolicLevelsMax,
											systolicLevelsMin: systolicLevelsMin == systolicLevelsMax ? nil : systolicLevelsMin,
											diastolicLevelMax: diastolicLevelMax,
											diastolicLevelMin: diastolicLevelMin == diastolicLevelMax ? nil : diastolicLevelMin,
											pulseMax: pulseMax,
											pulseMin: pulseMax == pulseMin ? nil : pulseMin,
											note: notesInfo,
											date: date)
		return info
	}
	
	// MARK: - init
	
	init(dataStore: DataStore) {
		self.dataStore = dataStore
		self.formattedDate = Date.now.formatted(.dateTime.month().year())
		self.currentDate = Date()
		startAlertTimerIfNeeded() 
	}
}

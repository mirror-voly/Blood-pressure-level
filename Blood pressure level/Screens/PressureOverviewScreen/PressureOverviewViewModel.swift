//
//  PressureOverviewViewModel.swift
//  Blood pressure level
//
//  Created by mix on 25.10.2024.
//

import SwiftUI
import Charts

final class PressureOverviewViewModel: ObservableObject {
	
	@Published var period: PresentationPeriod = .day {
		didSet {
			selectedMessurment = nil
		}
	}
	@Published var tipIsActive = false
	@Published var addNewScreenIsPresented = false
	@Published var isNoteViewOpened = false
	@Published var selectedMessurment: SelectedMeasurementsInfo?
	
	private let dataStore: DataStore
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
	private var filteredMeasurementsForPresentationPeriod: [Measurement] {
		getMeasurementsForPresentationPeriod()
	}
	var chartAverageMeasurements: [Measurement] {
		period != .day ? sortAndMakeAverageMeasurements(filteredMeasurementsForPresentationPeriod) : filteredMeasurementsForPresentationPeriod
	}
	var measurementsWithNotes: [Measurement] {
		let filterNotes = filteredMeasurementsForPresentationPeriod.filter({ $0.note != nil })
		
		return period != .day ? findAverageNote(filterNotes) : filterNotes
		
	}
	var timeInterval: (startOfPeriod: Date, endOfPeriod: Date) {
		getTimeInterval()
	}
	var minAndMaxPressureLevelInfo: String? {
		guard let info = getMinAndMaxPressureLevel() else { return nil }
		if let diastolicMin = info.diastolic.min, let systolicMin = info.systolic.min {
			return "\(systolicMin) - \(info.systolic.max) / \(diastolicMin) - \(info.diastolic.max)"
		} else {
			return "\(info.systolic.max) / \(info.diastolic.max)"
		}
	}
	var minAndMaxPulseLevelInfo: String? {
		guard let pulse = getMinAndMaxPulseLevel() else { return nil }
		if let min = pulse.min, min != pulse.max {
			return "\(min) - \(pulse.max)"
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
	private func sortByTime(measurements: [Measurement]) -> [Measurement] {
		measurements.sorted(by: { $0.date > $1.date	})
	}
	
	private func sortAndMakeAverageMeasurements(_ measurements: [Measurement]) -> [Measurement] {
		var groupedMeasurements: [Date: [Measurement]] = [:]
		var averagedMeasurements: [Measurement] = []
		for measurement in measurements {
			let dateKey = Calendar.current.startOfDay(for: measurement.date)
			groupedMeasurements[dateKey, default: []].append(measurement)
		}
		
		for (_, group) in groupedMeasurements {
			if !group.isEmpty {
				let averageSystolic = group.map { $0.systolicLevel }.reduce(0, +) / group.count
				let averageDiastolic = group.map { $0.diastolicLevel }.reduce(0, +) / group.count
				let averagedMeasurement = Measurement(systolicLevel: averageSystolic, diastolicLevel: averageDiastolic, id: UUID(), date: group[0].date, pulse: nil, note: nil)
				averagedMeasurements.append(averagedMeasurement)
			}
		}
		let sortedMeasurements = sortByTime(measurements: averagedMeasurements)
		return sortedMeasurements
	}
	
	func findAverageNote(_ filterNotes: [Measurement]) -> [Measurement] {
		let chartDates = Set(chartAverageMeasurements.map { Calendar.current.startOfDay(for: $0.date) })
		
		return filterNotes.compactMap { item in
			let itemDate = Calendar.current.startOfDay(for: item.date)
			return chartDates.contains(itemDate) ? chartAverageMeasurements.first(where: { Calendar.current.startOfDay(for: $0.date) == itemDate }) : nil
		}
	}

	private func getMeasurementsForPresentationPeriod() -> [Measurement] {
		let (startOfPeriod, endOfPeriod) = getTimeInterval()
		
		let filtered = dataStore.measurements.filter { measurement in
			return measurement.date >= startOfPeriod && measurement.date < endOfPeriod
		}
		
		return sortByTime(measurements: filtered)
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
				if let pulse = first.pulse {
					pulseInfo = (pulse, nil)
				} else {
					pulseInfo = nil
				}
			case let count where count > 1:
				let pulses = filteredMeasurementsForPresentationPeriod.compactMap { $0.pulse }
				guard let biggestPulse = pulses.max(), let smallestPulse = pulses.min() else { return nil }
				pulseInfo = (max: biggestPulse, min: smallestPulse)
			default:
				return nil
		}
		return pulseInfo
	}
	
	func makeSelectedInfo(measurements: [Measurement]) -> SelectedMeasurementsInfo? {
		guard let firstMeasurement = measurements.first else { return nil }
		let systolicLevels = measurements.map { $0.systolicLevel }
		let diastolicLevels = measurements.map { $0.diastolicLevel }
		let pulses = measurements.compactMap { $0.pulse }
		let notes = measurements.filter({ $0.note != nil })
		
		guard let systolicLevelsMax = systolicLevels.max(), let diastolicLevelMax = diastolicLevels.max() else { return nil }
		
		let	systolicLevelsMin = systolicLevels.min()
		let diastolicLevelMin = diastolicLevels.min()
		let pulseMax = pulses.max()
		let pulseMin = pulses.min()
		let date = firstMeasurement.date
		let notesInfo = notes.map { getNoteInfo(measurement: $0) }
		
		let info = SelectedMeasurementsInfo(systolicLevelsMax: systolicLevelsMax,
											systolicLevelsMin: systolicLevelsMin == systolicLevelsMax ? nil : systolicLevelsMin,
											diastolicLevelMax: diastolicLevelMax,
											diastolicLevelMin: diastolicLevelMin == diastolicLevelMax ? nil : systolicLevelsMin,
											pulseMax: pulseMax,
											pulseMin: pulseMax == pulseMin ? nil : pulseMin,
											note: notesInfo,
											date: date)
		return info
	}
	
	func getDateText(date: Date, formatStyle: PresentationPeriod) -> String {
		DatePrepare.formatDate(date: date, formatStyle: formatStyle)
	}
	
	func findAndSetSelection(xValue: Date) {
		let shift: Double = period == .day ? Constants.Time.halfanHour : Constants.Time.halfADay
		let measurements = filteredMeasurementsForPresentationPeriod.filter({ measurement in
			return measurement.date >= xValue.addingTimeInterval(-shift) && measurement.date <= xValue.addingTimeInterval(shift)
		})
		selectedMessurment = makeSelectedInfo(measurements: measurements)
	}
	
	func getNoteInfo(measurement: Measurement?) -> (time: String, text: String)? {
		guard let measurement = measurement, let note = measurement.note else { return nil }
		formatter.dateFormat = "d.MM H:mm"
		return (formatter.string(from: measurement.date), note)
	}
	
	func getNoteInfo() -> (time: String, text: String)? {
		guard let measurement = measurementsWithNotes.first, let note = measurement.note else { return nil }
		formatter.dateFormat = "d.MM H:mm"
		return (formatter.string(from: measurement.date), note)
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
	
	func startTimer() {
		let dispatchWorkItemON = DispatchWorkItem { 
			guard self.dataStore.measurements.isEmpty else { return }
			self.tipIsActive = true
		}
		let dispatchWorkItemOff = DispatchWorkItem {
			self.tipIsActive = false
		}
		DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: dispatchWorkItemON)
		DispatchQueue.main.asyncAfter(deadline: .now() + 15, execute: dispatchWorkItemOff)
	}
	
	init(dataStore: DataStore) {
		self.dataStore = dataStore
		self.formattedDate = Date.now.formatted(.dateTime.month().year())
		self.currentDate = Date()
		startTimer() 
	}
	
}

//
//  MeasurementsCalculator.swift
//  Blood pressure level
//
//  Created by mix on 30.10.2024.
//

import Foundation

/// Класс для вычисления и анализа уровней давления и пульса.
final class MeasurementsCalculator {
	
	// MARK: - Pressure levels
	
	/// Получает минимальные и максимальные уровни систолического и диастолического давления из массива измерений.
	/// - Parameter measurements: Массив измерений, из которого нужно получить данные.
	/// - Returns: Кортеж с максимальными и минимальными значениями систолического и диастолического давления, или `nil`, если измерения отсутствуют.
	func getMinAndMaxPressureLevel(_ measurements: [Measurement]?) -> (systolic: (max: Int, min: Int?), diastolic: (max: Int, min: Int?))? {
		guard let measurements = measurements else { return nil }
		
		let systolic: (Int, Int?)
		let diastolic: (Int, Int?)
		
		switch measurements.count {
		case 1:
			let first = measurements[0]
			systolic = (first.systolicLevel, nil)
			diastolic = (first.diastolicLevel, nil)
		case let count where count > 1:
			let systolicLevels = measurements.map { $0.systolicLevel }
			let diastolicLevels = measurements.map { $0.diastolicLevel }
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
	
	/// Получает строковое представление минимальных и максимальных уровней давления.
	/// - Parameter measurements: Массив измерений, из которого нужно получить данные.
	/// - Returns: Строка, представляющая минимальные и максимальные уровни давления, или `nil`, если измерения отсутствуют.
	func getMinAndMaxPressureLevelStringResult(_ measurements: [Measurement]?) -> String? {
		guard let info = getMinAndMaxPressureLevel(measurements) else { return nil }
		if let diastolicMin = info.diastolic.min, let systolicMin = info.systolic.min {
			return "\(systolicMin) - \(info.systolic.max) / \(diastolicMin) - \(info.diastolic.max)"
		} else {
			return "\(info.systolic.max) / \(info.diastolic.max)"
		}
	}
	
	// MARK: - Pulse levels
	
	/// Получает минимальный и максимальный уровни пульса из массива измерений.
	/// - Parameter measurements: Массив измерений, из которого нужно получить данные.
	/// - Returns: Кортеж с максимальным и минимальным значениями пульса, или `nil`, если измерения отсутствуют.
	func getMinAndMaxPulseLevel(_ measurements: [Measurement]?) -> (max: Int, min: Int?)? {
		guard let measurements = measurements else { return nil }
		let pulseInfo: (Int, Int?)?
		switch measurements.count {
		case 1:
			let first = measurements[0]
			if let pulse = first.pulse {
				pulseInfo = (pulse, nil)
			} else {
				pulseInfo = nil
			}
		case let count where count > 1:
			let pulses = measurements.compactMap { $0.pulse }
			guard let biggestPulse = pulses.max(), let smallestPulse = pulses.min() else { return nil }
			pulseInfo = (max: biggestPulse, min: smallestPulse)
		default:
			return nil
		}
		return pulseInfo
	}
	
	/// Получает строковое представление минимального и максимального уровней пульса.
	/// - Parameter measurements: Массив измерений, из которого нужно получить данные.
	/// - Returns: Строка, представляющая минимальный и максимальный уровни пульса, или `nil`, если измерения отсутствуют.
	func getMinAndMaxPulseLevelStringResult(_ measurements: [Measurement]?) -> String? {
		guard let pulse = getMinAndMaxPulseLevel(measurements) else { return nil }
		if let min = pulse.min, min != pulse.max {
			return "\(min) - \(pulse.max)"
		} else {
			return "\(pulse.max)"
		}
	}
}

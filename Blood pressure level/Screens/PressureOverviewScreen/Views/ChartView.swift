//
//  ChartView.swift
//  Blood pressure level
//
//  Created by mix on 27.10.2024.
//

import SwiftUI
import Charts

struct ChartView: View {
	
	@StateObject var viewModel: PressureOverviewViewModel

	
    var body: some View {
		
		let startOfDay = Calendar.current.startOfDay(for: Date())
		let endOfDay = startOfDay.addingTimeInterval(86400)
		
		
		Chart(viewModel.getMeasurementsForPresentationPeriod()) { measurement in
			Plot {
				LineMark(x: .value("Hour", measurement.date, unit: .hour), y: .value("SystolicLevel", measurement.systolicLevel))
					.foregroundStyle(by: .value("Pressure", "systolic"))
				
				LineMark(x: .value("Hour", measurement.date, unit: .hour), y: .value("SystolicLevel", measurement.diastolicLevel))
					.foregroundStyle(by: .value("Pressure", "diastolic"))
			}
			.interpolationMethod(.catmullRom)
			.lineStyle(StrokeStyle(lineWidth: 4))
		
			
			Plot {
				PointMark(x: .value("Hour", measurement.date, unit: .hour), y: .value("SystolicLevel", measurement.systolicLevel))
					.foregroundStyle(.systolic)
				
				PointMark(x: .value("Hour", measurement.date, unit: .hour), y: .value("DiastolicLevel", measurement.diastolicLevel))
					.foregroundStyle(.diastolic)
			}
			.symbolSize(35)
			
			Plot {
				RuleMark(y: .value("middle", 100))
				
				RuleMark(y: .value("top", 200))
				
				RuleMark(x: .value("startOfDay", startOfDay, unit: .minute))
			}
			.foregroundStyle(.gray.opacity(0.2))
			.lineStyle(
				StrokeStyle(
					lineWidth: 1,
					lineCap: .round,
					dash: [5, 5]
				)
			)
			
			Plot {
				RuleMark(x: .value("endOfDay", endOfDay, unit: .minute))
				
				RuleMark(y: .value("bottom", 0))	
			}
			.foregroundStyle(.black)
			.lineStyle(
				StrokeStyle(
					lineWidth: 1,
					lineCap: .round
				)
			)
			
			Plot {
				RuleMark(y: .value("high", 150))
					.foregroundStyle(.red.opacity(0.2))
				
				RuleMark(y: .value("low", 50))
					.foregroundStyle(.blue.opacity(0.2))
			}
			.lineStyle(
				StrokeStyle(
					lineWidth: 1,
					lineCap: .round,
					dash: [5, 5]
				)
			) 
		}
		.chartForegroundStyleScale(["systolic": .systolic.opacity(0.2),
									"diastolic": .diastolic.opacity(0.2)])
		.chartLegend(.hidden)
		// MARK: - Chart axis
		.chartYScale(domain: 0...200)
		.chartYAxis { 
			AxisMarks(values: [0, 50, 100, 150, 200])
		}

		// MARK: Day X axis
		.chartXScale(domain: startOfDay...endOfDay)
		.chartXAxis {
			AxisMarks(values: .automatic) { value in
				AxisValueLabel {
					if let date = value.as(Date.self) {
						let formatter = DateFormatter()
						formatter.dateFormat = "H"
						return Text(formatter.string(from: date))
					}
					return Text("")
				}
			}
		}
    }
}

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
		
		Chart {
			// MARK: - Chart data placement
			ForEach(viewModel.chartAverageMeasurements) { measurement in
				Plot {
					LineMark(x: .value("hour", measurement.date,
									   unit: viewModel.calendarComponentForPeriod),
							 y: .value("systolicLevel", measurement.systolicLevel))
					.foregroundStyle(by: .value("Pressure", "systolic"))
					
					LineMark(x: .value("hour", measurement.date,
									   unit: viewModel.calendarComponentForPeriod),
							 y: .value("systolicLevel", measurement.diastolicLevel))
					.foregroundStyle(by: .value("pressure", "diastolic"))
				}
				.interpolationMethod(.catmullRom)
				.lineStyle(StrokeStyle(lineWidth: 4))
				
				Plot {
					PointMark(x: .value("hour", measurement.date,
										unit: viewModel.calendarComponentForPeriod), y: .value("systolicLevel", measurement.systolicLevel))
					.foregroundStyle(.systolic)
					
					
					PointMark(x: .value("hour", measurement.date,
										unit: viewModel.calendarComponentForPeriod),
							  y: .value("diastolicLevel", measurement.diastolicLevel))
					.foregroundStyle(.diastolic)
				}
				.symbolSize(40)
			}
			
			ForEach(viewModel.measurementsWithNotes) { measurement in
				PointMark(x: .value("hour", measurement.date,
									unit: .second),
						  y: .value("systolicLevel", measurement.systolicLevel))
				.symbol {
					Image(systemName: "circle")
						.resizable()
						.bold()
						.foregroundStyle(.blue)
						.frame(width: 6, height: 6)
						.offset(x: 10, y: -10)
				}
			}
			// MARK: - Chart lines
			Plot {
				RuleMark(y: .value("middle", 100))
				
				RuleMark(y: .value("top", 200))
				
				RuleMark(x: .value("start", viewModel.timeInterval.startOfPeriod, unit: .minute))
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
				RuleMark(x: .value("end", viewModel.timeInterval.endOfPeriod, unit: .minute))
				
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
					.foregroundStyle(.red.opacity(0.5))
				
				RuleMark(y: .value("low", 50))
					.foregroundStyle(.blue.opacity(0.5))
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
		// MARK: - Selection
		.chartOverlay { chart in
			GeometryReader { geo in
				Rectangle()
					.fill(Color.clear)
					.contentShape(Rectangle())
					.gesture(
						DragGesture(minimumDistance: 0)
							.onEnded { value in
								let start = geo[chart.plotAreaFrame].origin.x
								let xCurrent = value.location.x - start
								
								guard let xValue = chart.value(atX: xCurrent, as: Date.self) else { return }

								viewModel.findAndSetSelection(xValue: xValue)
							}
					)
			}
		}

		.chartLegend(.hidden)
		// MARK: - Chart axis
		.chartYScale(domain: 0...200)
		.chartYAxis {
			AxisMarks(values: [0, 50, 100, 150, 200]) { value in
				if let number = value.as(Int.self) {
					AxisValueLabel {
						return Text("\(number)")
							.foregroundStyle(
								number == 50 ? .blue :
									number == 150 ? .red :
										.main.opacity(0.5)
							)
					}
				}
			}
		}
		
		// MARK: Day X axis
		.chartXScale(domain: viewModel.timeInterval.startOfPeriod...viewModel.timeInterval.endOfPeriod)
		.chartXAxis {
			AxisMarks(values: viewModel.getAxisValues()) { value in
				AxisValueLabel {
					if let date = value.as(Date.self) {
						return Text(viewModel.formatDate(for: date))
					}
					return Text("")
				}
			}
		}
	}
}

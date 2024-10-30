//
//  ChartView.swift
//  Blood pressure level
//
//  Created by mix on 27.10.2024.
//

import SwiftUI
import Charts

struct ChartView: View {
	
	@EnvironmentObject private var viewModel: PressureOverviewViewModel
	
	var body: some View {
		Chart {
			// MARK: - Chart data placement
			ForEach(viewModel.chartAverageMeasurements) { measurement in
				Plot {
					LineMark(x: .value("hour", measurement.date,
									   unit: viewModel.chartUnitForPeriod),
							 y: .value("systolicLevel", measurement.systolicLevel))
					.foregroundStyle(by: .value("Pressure", "systolic"))
					
					LineMark(x: .value("hour", measurement.date,
									   unit: viewModel.chartUnitForPeriod),
							 y: .value("systolicLevel", measurement.diastolicLevel))
					.foregroundStyle(by: .value("pressure", "diastolic"))
				}
				.interpolationMethod(.catmullRom)
				.lineStyle(StrokeStyle(lineWidth: Constants.Chart.curveLineWidth))
				
				Plot {
					PointMark(x: .value("hour", measurement.date,
										unit: viewModel.chartUnitForPeriod),
							  y: .value("systolicLevel", measurement.systolicLevel))
					.foregroundStyle(.systolic)
					
					
					PointMark(x: .value("hour", measurement.date,
										unit: viewModel.chartUnitForPeriod),
							  y: .value("diastolicLevel", measurement.diastolicLevel))
					.foregroundStyle(.diastolic)
				}
				.symbolSize(Constants.Chart.symbolSize)
			}
			// MARK: - Chart note icons
			ForEach(viewModel.measurementsWithNote) { measurement in
				PointMark(x: .value("hour", measurement.date,
									unit: viewModel.chartUnitForPeriod),
						  y: .value("systolicLevel", measurement.systolicLevel))
				.symbol {
					Image(systemName: "circle")
						.resizable()
						.bold()
						.foregroundStyle(.blue)
						.frame(width: Constants.FrameSize.overlaySelectionNoteIconSize,
							   height: Constants.FrameSize.overlaySelectionNoteIconSize)
						.offset(x: Constants.Chart.offset, y: -Constants.Chart.offset)
				}
			}
			// MARK: - Chart lines
			Plot {
				RuleMark(y: .value("middle", Constants.Chart.middleLine))
				
				RuleMark(y: .value("top", Constants.Chart.topLine))
				
				RuleMark(x: .value("start", viewModel.timeInterval.startOfPeriod, unit: .minute))
			}
			.foregroundStyle(.gray.opacity(Constants.Opacity.small))
			.lineStyle(
				StrokeStyle(
					lineWidth: Constants.General.originalValue,
					lineCap: .round,
					dash: [Constants.Chart.lineDash, Constants.Chart.lineDash]
				)
			)
			
			Plot {
				RuleMark(x: .value("end", viewModel.timeInterval.endOfPeriod, unit: .minute))
				
				RuleMark(y: .value("bottom", Constants.Chart.zeroLine))	
			}
			.foregroundStyle(.black)
			.lineStyle(
				StrokeStyle(
					lineWidth: Constants.General.originalValue,
					lineCap: .round
				)
			)
			
			Plot {
				RuleMark(y: .value("high", Constants.Chart.highLine))
					.foregroundStyle(.red.opacity(Constants.Opacity.big))
				
				RuleMark(y: .value("low", Constants.Chart.lowLine))
					.foregroundStyle(.blue.opacity(Constants.Opacity.big))
			}
			.lineStyle(
				StrokeStyle(
					lineWidth: Constants.General.originalValue,
					lineCap: .round,
					dash: [Constants.Chart.lineDash, Constants.Chart.lineDash]
				)
			) 
		}
		.chartForegroundStyleScale(["systolic": .systolic.opacity(Constants.Opacity.small),
									"diastolic": .diastolic.opacity(Constants.Opacity.small)])
		// MARK: - Selection
		.chartOverlay { chart in
			GeometryReader { geo in
				Rectangle()
					.fill(Color.clear)
					.contentShape(Rectangle())
					.gesture(
						DragGesture(minimumDistance: .zero)
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
		.chartYScale(domain: Constants.Chart.scaleDomain)
		.chartYAxis {
			AxisMarks(values: Constants.Chart.chartYAxisMarks) { value in
				if let number = value.as(Int.self) {
					AxisValueLabel {
						return Text("\(number)")
							.foregroundStyle(
								number == Constants.Chart.lowLine ? .blue :
									number == Constants.Chart.highLine ? .red :
										.main.opacity(Constants.Opacity.big)
							)
					}
				}
			}
		}
		
//		 MARK: X axis
		.chartXScale(domain: viewModel.timeInterval.startOfPeriod...viewModel.timeInterval.endOfPeriod)
		.chartXAxis {
			AxisMarks(values: viewModel.getChartAxisValues()) { value in
				AxisValueLabel {
					if let date = value.as(Date.self) {
						return Text(viewModel.formatChartXAxisDateFor(date: date))
					}
					return Text(Constants.General.emptyString)
				}
			}
		}
	}
}

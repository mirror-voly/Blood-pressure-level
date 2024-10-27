//
//  PressureChartsView.swift
//  Blood pressure level
//
//  Created by mix on 24.10.2024.
//

import SwiftUI
import Charts

struct PressureChartsView: View {
	
	@StateObject var viewModel: PressureOverviewViewModel
	
	var body: some View {
		VStack(alignment: .leading, spacing: Constants.Spacing.defaultSpacing) {
			HStack(content: {
				Text("no_data".localized)
					.font(.system(size: Constants.FontSize.big))
					.bold()
				Spacer()
			})
			
			HStack {
				Text("today".localized)
					.foregroundStyle(.main.opacity(Constants.Opacity.regular))
					.font(.system(size: Constants.FontSize.micro))
			}
			
			Divider()
			
			HStack(spacing: Constants.Spacing.defaultSpacing) {
				Group {
					Circle()
						.fill(.systolic)
					
					Text("systolic".localized)
					
					Circle()
						.fill(.diastolic)
					
					Text("diastolic".localized)
				}
				.frame(height: Constants.FrameSize.chartLegendHeight)
				.font(.system(size: Constants.FontSize.verySmall))
				
				Spacer()
			}
			
			Chart {
				ForEach(viewModel.dataStore.measurements) { measurement in
					LineMark(x: .value("Hour", measurement.date, unit: .hour), y: .value("SystolicLevel", measurement.pressure.systolicLevel))
						.foregroundStyle(.systolic.opacity(0.2))
					
					PointMark(x: .value("Hour", measurement.date, unit: .hour), y: .value("SystolicLevel", measurement.pressure.systolicLevel))
						.foregroundStyle(.systolic)
				}
				RuleMark(y: .value("high", 150))
					.foregroundStyle(.red.opacity(0.3))
				
				RuleMark(y: .value("low", 50))
					.foregroundStyle(.blue.opacity(0.3))
			}			
			// MARK: - Chart legends
			.chartYAxis(content: { 
				AxisMarks(values: [0, 50, 100, 150, 200])
			})
			// MARK: Day legend
			.chartXScale(domain: Calendar.current.startOfDay(for: Date())...Calendar.current.startOfDay(for: Date()).addingTimeInterval(86400))
			.chartXAxis {
				AxisMarks { value in
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
			
			Spacer()
			
			Button(action: {
				viewModel.addNewScreenIsPresented = true
			}, label: {
				Text("add_data".localized)
					.font(.system(size: Constants.FontSize.verySmall))
					.padding(.vertical, Constants.Padding.small)
					.padding(.horizontal, Constants.Padding.regular)
					.foregroundStyle(.systolic)
					.background(.scheme)
					.clipShape(.capsule)
					.buttonBorderShape(.capsule)
					.overlay(
						RoundedRectangle(cornerRadius: Constants.Radius.regular)
							.stroke(.systolic, lineWidth: Constants.General.originalValue))
			})
			.frame(maxWidth: .infinity, alignment: .bottomTrailing)
			
		}
		.padding(.horizontal)
		.padding(.vertical, Constants.Padding.big)
		.background(.scheme)
		.frame(maxWidth: .infinity)
		.clipShape(RoundedRectangle(cornerRadius: Constants.Radius.big))
	}
}

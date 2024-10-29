//
//  PressureChartsView.swift
//  Blood pressure level
//
//  Created by mix on 24.10.2024.
//

import SwiftUI

struct PressureSummaryView: View {
	
	@StateObject var viewModel: PressureOverviewViewModel
	
	var body: some View {
		VStack(alignment: .leading, spacing: Constants.Spacing.regular) {
			
			VStack(alignment: .leading, spacing: Constants.Spacing.small, content: {
				if let info = viewModel.minAndMaxPressureLevelInfo {
					HStack(alignment: .center, content: {
						Text("pressure".localized)
							.font(.system(size: Constants.FontSize.verySmall))
							.foregroundStyle(.main.opacity(Constants.Opacity.big))
							.frame(width: Constants.FrameSize.textItemWidth, alignment: .leading)
						
						HStack(alignment: .bottom, content: {
							Text(info)
								.font(.system(size: Constants.FontSize.big))
								.bold()
							
							Text("mmHg".localized)
								.font(.system(size: Constants.FontSize.verySmall))
								.foregroundStyle(.main.opacity(Constants.Opacity.big))
						})
						Spacer()
					})
					
					if let pulseInfo = viewModel.minAndMaxPulseLevelInfo {
						HStack(alignment: .center, content: {
							Text("pulse".localized)
								.font(.system(size: Constants.FontSize.verySmall))
								.foregroundStyle(.main.opacity(Constants.Opacity.big))
								.frame(width: Constants.FrameSize.textItemWidth, alignment: .leading)
							
							HStack(alignment: .bottom, content: {
								Text(pulseInfo)
									.font(.system(size: Constants.FontSize.big))
									.bold()
								
								Text("bpm".localized)
									.font(.system(size: Constants.FontSize.verySmall))
									.foregroundStyle(.main.opacity(Constants.Opacity.big))
							})
							
							Spacer()
						})
					}
				} else {
					Text("no_data".localized)
						.font(.system(size: Constants.FontSize.big))
						.bold()
					
				}
			})
			.frame(maxHeight: Constants.FrameSize.summaryMaxHeight)
			
			HStack {
				if viewModel.period != .day {
					Text(viewModel.periodInfo.capitalized)
						.font(.system(size: Constants.FontSize.micro))
				} else {
					Text("today".localized)
						.font(.system(size: Constants.FontSize.micro))
				}
				
			}
			
			Divider()
			
			HStack(spacing: Constants.Spacing.regular) {
				Group {
					Circle()
						.fill(.systolic)
					
					Text("systolic".localized)
					
					Circle()
						.fill(.diastolic)
					
					Text("diastolic".localized)
				}
				.frame(height: Constants.Chart.chartLegendHeight)
				.font(.system(size: Constants.FontSize.verySmall))
				
				Spacer()
			}
			
			ChartView(viewModel: viewModel)
				.frame(maxWidth: .infinity, maxHeight: Constants.Chart.maxHeight)
			
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
		.clipShape(RoundedRectangle(cornerRadius: Constants.Radius.big))
		
		.overlay { 
			OverlaySelectionPresenter(viewModel: viewModel)
				.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
		}
	}
}

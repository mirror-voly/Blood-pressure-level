//
//  SmallOverlayView.swift
//  Blood pressure level
//
//  Created by mix on 29.10.2024.
//

import SwiftUI

struct SmallOverlayView: View {
	
	@StateObject var viewModel: PressureOverviewViewModel
	let selectedMessurment: SelectedMeasurementsInfo
	
	var body: some View {
		VStack(alignment: .center, spacing: Constants.Spacing.small, content: {
			HStack(alignment: .top, spacing: Constants.Spacing.regular) {
				
				VStack(alignment: .leading, spacing: Constants.Spacing.regular, content: {
					VStack(alignment: .leading, content: {
						Text("pressure".localized)
							.font(.system(size: Constants.FontSize.verySmall))
							.foregroundStyle(.main.opacity(Constants.Opacity.big))
						
						Text("\(selectedMessurment.systolicLevelsMax) / \(selectedMessurment.diastolicLevelMax)")
							.font(.system(size: Constants.FontSize.big))
							.bold()
						
						
						Text("mmHg".localized)
							.font(.system(size: Constants.FontSize.verySmall))
							.foregroundStyle(.main.opacity(Constants.Opacity.big))
					})
				})
				
				if let pulseMax = selectedMessurment.pulseMax {
					VStack(alignment: .leading, content: {
						Text("pulse".localized)
							.font(.system(size: Constants.FontSize.verySmall))
							.foregroundStyle(.main.opacity(Constants.Opacity.big))
						
						Text("\(pulseMax)")
							.font(.system(size: Constants.FontSize.big))
							.bold()
						
						Text("bpm".localized)
							.font(.system(size: Constants.FontSize.verySmall))
							.foregroundStyle(.main.opacity(Constants.Opacity.big))
					})
				}
			}
			
			VStack(alignment: .center, spacing: Constants.Spacing.verySmall) {
				// TODO: Change for "Today"
				if viewModel.period == .day {
					HStack(spacing: Constants.Spacing.verySmall){
						Text("today".localized)
							.font(.system(size: Constants.FontSize.micro))	
						Text(viewModel.getDateText(date: selectedMessurment.date, formatStyle: .day))
							.font(.system(size: Constants.FontSize.micro))	
					}
				} else {
					Text(viewModel.getDateText(date: selectedMessurment.date, formatStyle: .month))
						.font(.system(size: Constants.FontSize.micro))
				}
				if selectedMessurment.note.first != nil {
					NoteOverlayView()
				}
			}
			
		})
		.padding()
		.background(.backgroundMain)
		.clipShape(RoundedRectangle(cornerRadius: Constants.Radius.regular))
		.overlay(
			RoundedRectangle(cornerRadius: Constants.Radius.verySmall)
				.stroke(.overlayBorder, lineWidth: Constants.General.originalValue)
		)
		.frame(maxHeight: Constants.FrameSize.overlaySelectionFrameMaxHeight)
	}
}

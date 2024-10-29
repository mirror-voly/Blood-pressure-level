//
//  BigOverlayView.swift
//  Blood pressure level
//
//  Created by mix on 29.10.2024.
//

import SwiftUI

struct BigOverlayView: View {
	
	@StateObject var viewModel: PressureOverviewViewModel
	let selectedMessurment: SelectedMeasurementsInfo
	
    var body: some View {
		
		if let systolicLevelsMin = selectedMessurment.systolicLevelsMin {
			VStack(spacing: .zero, content: {
				HStack(alignment: .top, spacing: Constants.Spacing.regular) {
					VStack(alignment: .leading, spacing: Constants.Spacing.regular, content: {
						
						VStack(alignment: .leading, content: {
							Text("systolic".localized)
								.font(.system(size: Constants.FontSize.verySmall))
								.foregroundStyle(.main.opacity(Constants.Opacity.big))
								.frame(width: Constants.FrameSize.textItemWidth, alignment: .leading)
							
							Text("\(systolicLevelsMin) - \(selectedMessurment.systolicLevelsMax)")
								.font(.system(size: Constants.FontSize.big))
								.bold()
							
							Text("mmHg".localized)
								.font(.system(size: Constants.FontSize.verySmall))
								.foregroundStyle(.main.opacity(Constants.Opacity.big))
						})
						
						VStack(alignment: .leading, content: {
							if let pulseMax = selectedMessurment.pulseMax {
								Text("pulse".localized)
									.font(.system(size: Constants.FontSize.verySmall))
									.foregroundStyle(.main.opacity(Constants.Opacity.big))
									.frame(width: Constants.FrameSize.textItemWidth, alignment: .leading)
								
								Group {
									if let pulseMin = selectedMessurment.pulseMin {
										Text("\(pulseMin) - \(pulseMax)")
									} else {
										Text("\(pulseMax)")
									}
								}
								.font(.system(size: Constants.FontSize.big))
								.bold()
								
								Text("bpm".localized)
									.font(.system(size: Constants.FontSize.verySmall))
									.foregroundStyle(.main.opacity(Constants.Opacity.big))
							}
						})
					})
					
					VStack(alignment: .leading, spacing: Constants.Spacing.regular, content: {
						VStack(alignment: .leading, content: {
							Text("diastolic".localized)
								.font(.system(size: Constants.FontSize.verySmall))
								.foregroundStyle(.main.opacity(Constants.Opacity.big))
								.frame(width: Constants.FrameSize.textItemWidth, alignment: .leading)
							
							Group {
								if let diastolicLevelMin = selectedMessurment.diastolicLevelMin {
									Text("\(diastolicLevelMin) - \(selectedMessurment.diastolicLevelMax)")
								} else {
									Text("\(selectedMessurment.diastolicLevelMax)")
								}
							}
							.font(.system(size: Constants.FontSize.big))
							.bold()
							
							Text("mmHg".localized)
								.font(.system(size: Constants.FontSize.verySmall))
								.foregroundStyle(.main.opacity(Constants.Opacity.big))
						})
						
						Spacer()
						
						VStack(alignment: .leading, content: {
							Text(viewModel.getDateText(date: selectedMessurment.date, formatStyle: .month))
								.font(.system(size: Constants.FontSize.micro))
							
							if selectedMessurment.note.first != nil {
								NoteOverlayView()
							}
						})
						
					})
				}
				.padding()
				.background(.backgroundMain)
				.clipShape(RoundedRectangle(cornerRadius: Constants.Radius.regular))
				.overlay(
					RoundedRectangle(cornerRadius: Constants.Radius.verySmall)
						.stroke(.overlayBorder, lineWidth: Constants.General.originalValue)
				)
			})
			.frame(maxHeight: Constants.FrameSize.overlaySelectionFrameMaxHeight)
		}
    }
}

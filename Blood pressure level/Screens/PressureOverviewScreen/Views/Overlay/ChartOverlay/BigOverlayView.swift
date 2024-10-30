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
			HStack(spacing: Constants.Spacing.regular) {
				VStack(alignment: .leading, spacing: Constants.Spacing.regular) {
					OverlayMeasurementView(title: "systolic".localized,
											  minValue: "\(systolicLevelsMin)",
											  maxValue: "\(selectedMessurment.systolicLevelsMax)",
											  unit: "mmHg".localized)
					
					BigOverlayPulseView(pulseMax: selectedMessurment.pulseMax, pulseMin: selectedMessurment.pulseMin)
				}
				
				VStack(alignment: .leading, spacing: Constants.Spacing.regular) {
					OverlayMeasurementView(title: "diastolic".localized,
											  minValue: "\(selectedMessurment.diastolicLevelMin ?? selectedMessurment.diastolicLevelMax)",
											  maxValue: "\(selectedMessurment.diastolicLevelMax)",
											  unit: "mmHg".localized)
					
					Spacer()
					
					VStack(alignment: .leading) {
						SmallOverlayDateView(viewModel: viewModel, selectedMessurment: selectedMessurment, formatStyle: .month)
						
						if selectedMessurment.note.first != nil {
							NoteOverlayView()
						}
					}
				}
			}
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
}

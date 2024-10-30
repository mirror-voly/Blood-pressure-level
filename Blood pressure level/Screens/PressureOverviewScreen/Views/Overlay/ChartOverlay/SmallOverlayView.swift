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
		VStack(alignment: .center, spacing: Constants.Spacing.small) {
			HStack(alignment: .top, spacing: Constants.Spacing.regular) {
				OverlayMeasurementView(title: "pressure".localized, minValue: nil, maxValue: "\(selectedMessurment.systolicLevelsMax) / \(selectedMessurment.diastolicLevelMax)", unit: "mmHg".localized)
				
				if let pulseMax = selectedMessurment.pulseMax {
					OverlayMeasurementView(title: "pulse".localized, minValue: nil, maxValue: "\(pulseMax)", unit: "bpm".localized)

				}
			}
			
			SmallOverlayDateView(viewModel: viewModel, selectedMessurment: selectedMessurment, formatStyle: .day)
			
			if selectedMessurment.note.first != nil {
				NoteOverlayView()
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

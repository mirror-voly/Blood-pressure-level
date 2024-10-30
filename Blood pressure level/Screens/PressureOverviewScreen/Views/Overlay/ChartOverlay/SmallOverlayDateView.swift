//
//  SmallOverlayViewDateView.swift
//  Blood pressure level
//
//  Created by mix on 30.10.2024.
//

import SwiftUI

struct SmallOverlayDateView: View {
	
	@EnvironmentObject private var viewModel: PressureOverviewViewModel
	let selectedMessurment: SelectedMeasurementsInfo
	let formatStyle: PresentationPeriod
	
	var body: some View {
		VStack(alignment: .center, spacing: Constants.Spacing.verySmall) {
			if viewModel.period == .day {
				HStack(spacing: Constants.Spacing.verySmall) {
					Text("today".localized)
						.font(.system(size: Constants.FontSize.micro))
					Text(viewModel.getDateText(date: selectedMessurment.date, formatStyle: formatStyle))
						.font(.system(size: Constants.FontSize.micro))
				}
			} else {
				Text(viewModel.getDateText(date: selectedMessurment.date, formatStyle: .month))
					.font(.system(size: Constants.FontSize.micro))
			}
		}
	}
}

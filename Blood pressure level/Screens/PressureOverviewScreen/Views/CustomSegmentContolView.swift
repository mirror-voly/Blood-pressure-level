//
//  CustomSegmentContolView.swift
//  Blood pressure level
//
//  Created by mix on 23.10.2024.
//

import SwiftUI

struct CustomSegmentContolView: View {
	
	@StateObject var viewModel: PressureOverviewViewModel
	
	var body: some View {
		HStack(spacing: Constants.SegmentedControl.spacing, content: {
			ForEach(PresentationPeriod.allCases, id: \.self) { period in
				Button(action: {
					viewModel.period = period
				}, label: {
					Text(String(describing: period).localized)
						.font(.system(size: Constants.FontSize.small))
						.foregroundStyle(.main)
						.frame(maxWidth: Constants.SegmentedControl.buttonWidth,
							   maxHeight: Constants.SegmentedControl.height)
						.background(viewModel.period == period ? .secondaryGray.opacity(Constants.Opacity.regular) : .clear)
						.bold(viewModel.period == period ? true : false)
						.clipShape(Capsule())
				})
				.padding(Constants.SegmentedControl.padding)
			}
		})
		.background(.scheme)
		.clipShape(Capsule())
	}
}

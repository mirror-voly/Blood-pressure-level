//
//  CustomSegmentContolView.swift
//  Blood pressure level
//
//  Created by mix on 23.10.2024.
//

import SwiftUI

struct CustomSegmentContolView: View {
	
	@Binding var period: PresentationPeriod

    var body: some View {
		HStack(spacing: Constants.SegmentedControl.spacing, content: {
			ForEach(PresentationPeriod.allCases, id: \.self) { period in
				Button(action: {
						self.period = period
				}, label: {
					Text(String(describing: period).capitalized)
						.font(.system(size: Constants.FontSize.small))
						.foregroundStyle(.main)
						.frame(maxWidth: Constants.SegmentedControl.buttonWidth,
							   maxHeight: Constants.SegmentedControl.height)
						.background(self.period == period ? .secondaryGray.opacity(Constants.Opacity.regular) : .clear)
						.bold(self.period == period ? true : false)
						.clipShape(Capsule())
				})
				.padding(Constants.SegmentedControl.padding)
			}
		})
		.background(.scheme)
		.clipShape(Capsule())
    }
}

#Preview {
	CustomSegmentContolView(period: .constant(.day))
}

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
		HStack(spacing: 6, content: {
			ForEach(PresentationPeriod.allCases, id: \.self) { period in
				Button(action: {
					withAnimation { 
						self.period = period
					}
				}, label: {
					Text(String(describing: period).capitalized)
						.font(.system(size: 14))
						.foregroundStyle(.main)
						.frame(maxWidth: 99, maxHeight: 26)
						.background(self.period == period ? .main.opacity(0.1) : .clear)
						.bold(self.period == period ? true : false)
						.clipShape(Capsule())
				})
				.padding(10)
			}
		})
		.background(.scheme)
		.clipShape(Capsule())

    }
}

#Preview {
	CustomSegmentContolView(period: .constant(.day))
}

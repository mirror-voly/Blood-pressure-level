//
//  OverlayMeasurementView.swift
//  Blood pressure level
//
//  Created by mix on 30.10.2024.
//

import SwiftUI

import SwiftUI

struct OverlayMeasurementView: View {
	
	let title: String
	let minValue: String? // Optional minValue
	let maxValue: String
	let unit: String
	
	var body: some View {
		VStack(alignment: .leading) {
			Text(title)
				.font(.system(size: Constants.FontSize.verySmall))
				.foregroundStyle(.main.opacity(Constants.Opacity.big))
				.lineLimit(1)
				.fixedSize()
			
			// Display minValue if it exists, otherwise just show maxValue
			if let minValue = minValue {
				Text("\(minValue) - \(maxValue)")
					.font(.system(size: Constants.FontSize.big))
					.bold()
			} else {
				Text(maxValue)
					.font(.system(size: Constants.FontSize.big))
					.bold()
			}
			
			Text(unit)
				.font(.system(size: Constants.FontSize.verySmall))
				.foregroundStyle(.main.opacity(Constants.Opacity.big))
		}
	}
}

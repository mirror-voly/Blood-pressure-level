//
//  BigOverlayPulseView.swift
//  Blood pressure level
//
//  Created by mix on 30.10.2024.
//

import SwiftUI


struct BigOverlayPulseView: View {
	let pulseMax: Int?
	let pulseMin: Int?
	
	var body: some View {
		VStack(alignment: .leading) {
			if let pulseMax = pulseMax {
				Text("pulse".localized)
					.font(.system(size: Constants.FontSize.verySmall))
					.foregroundStyle(.main.opacity(Constants.Opacity.big))
					.lineLimit(1)
				
				Text(pulseMin != nil ? "\(pulseMin!) - \(pulseMax)" : "\(pulseMax)")
					.font(.system(size: Constants.FontSize.big))
					.bold()
				
				Text("bpm".localized)
					.font(.system(size: Constants.FontSize.verySmall))
					.foregroundStyle(.main.opacity(Constants.Opacity.big))
			}
		}
	}
}

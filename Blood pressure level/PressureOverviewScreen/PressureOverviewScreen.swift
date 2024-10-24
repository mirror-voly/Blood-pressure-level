//
//  PressureOverviewScreen.swift
//  Blood pressure level
//
//  Created by mix on 23.10.2024.
//

import SwiftUI


struct PressureOverviewScreen: View {
	
	@State var period: PresentationPeriod = .day
	@State var tipIsActive = false
	
	var body: some View {
		ZStack {
			BackgroundView()
			
			VStack {
				PresureOverviewHeaderView()
					.padding(.vertical)
				
				VStack(spacing: 16) {
					CustomSegmentContolView(period: $period)

					PressureChartsView()

					PresureNoteView()

				}
				
				Spacer()

			}
			.padding(.horizontal)

			if tipIsActive {
				OverlayTip(tipIsActive: $tipIsActive)
			}
		}
	}
}


#Preview {
    PressureOverviewScreen()
}

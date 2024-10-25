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
	@State var addNewScreenIsPresented = false
	
	var body: some View {
		ZStack {
			BackgroundView(backgroundType: .mainScreen)
			
			VStack {
				PresureOverviewHeaderView(addNewScreenIsPresented: $addNewScreenIsPresented)
					.padding(.vertical)
				
				VStack(spacing: 16) {
					CustomSegmentContolView(period: $period)

					PressureChartsView(addNewScreenIsPresented: $addNewScreenIsPresented)

					PresureNoteView()

				}
				
				Spacer()

			}
			.padding(.horizontal)

			if tipIsActive {
				OverlayTip(tipIsActive: $tipIsActive)
			}
		}
		.fullScreenCover(isPresented: $addNewScreenIsPresented, content: { 
			AddNewMeasurementScreen()
		})

	}
}


#Preview {
    PressureOverviewScreen()
}

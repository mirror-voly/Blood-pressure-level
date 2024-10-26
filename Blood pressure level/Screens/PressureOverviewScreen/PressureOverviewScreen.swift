//
//  PressureOverviewScreen.swift
//  Blood pressure level
//
//  Created by mix on 23.10.2024.
//

import SwiftUI

struct PressureOverviewScreen: View {
	
	@StateObject private var viewModel = PressureOverviewViewModel(dataStore: DataStore.shared)
	
	var body: some View {
		NavigationStack {
			ZStack {
				BackgroundView(backgroundType: .mainScreen)
				
				VStack {
					PresureOverviewHeaderView(viewModel: viewModel)
						.padding(.vertical)
					
					VStack(spacing: Constants.Spacing.defaultSpacing) {
						CustomSegmentContolView(viewModel: viewModel)
						
						PressureChartsView(viewModel: viewModel)
						
						PresureNoteView(viewModel: viewModel)
					}
					
					Spacer()
				}
				.padding(.horizontal)
				
				if viewModel.tipIsActive {
					OverlayTip(viewModel: viewModel)
				}
			}
			.navigationDestination(isPresented: $viewModel.addNewScreenIsPresented) {
				AddNewMeasurementScreen()
			}
		}
	}
}


#Preview {
    PressureOverviewScreen()
}

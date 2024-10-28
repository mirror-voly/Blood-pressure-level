//
//  PressureOverviewScreen.swift
//  Blood pressure level
//
//  Created by mix on 23.10.2024.
//

import SwiftUI

struct PressureOverviewScreen: View {
	
	@EnvironmentObject var dataStore: DataStore
	@Environment(\.managedObjectContext) var managedObjectContext
	@FetchRequest(sortDescriptors: []) var measurementData: FetchedResults<MeasurementData>
	@StateObject private var viewModel: PressureOverviewViewModel
	
	var body: some View {
		NavigationStack {
			ZStack {
				BackgroundView(backgroundType: .mainScreen)
					.onAppear(perform: {
						print(measurementData.count)
					})
				VStack {
					PresureOverviewHeaderView(viewModel: viewModel)
						.padding(.bottom)
					
					VStack(spacing: Constants.Spacing.defaultSpacing) {
						CustomSegmentContolView(viewModel: viewModel)
						
						PressureSummaryView(viewModel: viewModel)
						
						PresureNoteView(viewModel: viewModel)
					}
					
					Spacer()
				}
				.padding(.horizontal)
				
				if viewModel.tipIsActive {
					//TODO: Need to highlight button too
					OverlayTip(viewModel: viewModel)
				}
			}
			.navigationDestination(isPresented: $viewModel.addNewScreenIsPresented) {
				AddNewMeasurementScreen(dataStore: dataStore)
			}
		}
	}
	
	init(dataStore: DataStore) {
		self._viewModel = StateObject(wrappedValue: PressureOverviewViewModel(dataStore: dataStore))
	}
}


#Preview {
	PressureOverviewScreen(dataStore: DataStore.shared)
}

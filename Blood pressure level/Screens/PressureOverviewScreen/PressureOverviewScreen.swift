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
			VStack {
				PresureOverviewHeaderView()
					.padding(.bottom)
				
				VStack(spacing: Constants.Spacing.regular) {
					CustomSegmentContolView()
					
					PressureSummaryView()
					
					PresureNoteView()
				}
				Spacer()
			}
			.padding(.horizontal)
			.background(BackgroundView(backgroundType: .mainScreen))
			.overlay { 
				OverlayTip()
			}
			.navigationDestination(isPresented: $viewModel.addNewScreenIsPresented) {
				AddNewMeasurementScreen(dataStore: dataStore)
			}
		}
		.environmentObject(viewModel)
	}
	
	init(dataStore: DataStore) {
		self._viewModel = StateObject(wrappedValue: PressureOverviewViewModel(dataStore: dataStore))
	}
}


#Preview {
	PressureOverviewScreen(dataStore: DataStore.shared)
}

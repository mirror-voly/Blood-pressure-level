//
//  PressureOverviewViewModel.swift
//  Blood pressure level
//
//  Created by mix on 25.10.2024.
//

import SwiftUI
import RxSwift
import RxCocoa

final class PressureOverviewViewModel: ObservableObject {
	
	let dataStore: DataStore
	@Published var formattedDate = Date.now.formatted(.dateTime.month().year())
	
	@Published var period: PresentationPeriod = .day
	@Published var tipIsActive = false
	@Published var addNewScreenIsPresented = false
	
	init(dataStore: DataStore) {
		self.dataStore = dataStore
	}
	
}

//
//  Blood_pressure_levelApp.swift
//  Blood pressure level
//
//  Created by mix on 23.10.2024.
//

import SwiftUI

@main
struct Blood_pressure_levelApp: App {
    let persistenceController = PersistenceController.shared
	let dataStore = DataStore.shared
	
    var body: some Scene {
        WindowGroup {
			PressureOverviewScreen(dataStore: dataStore)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
				.environmentObject(dataStore)
        }
    }
}

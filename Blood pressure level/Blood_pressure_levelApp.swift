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

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

//
//  Persistence.swift
//  Blood pressure level
//
//  Created by mix on 23.10.2024.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer
	
	static func convertAndSaveAllMeasurements(measurement: [Measurement]) {
		let result = PersistenceController(inMemory: true)
		let context = result.container.viewContext
		measurement.forEach { measurement in
			let measurementData = MeasurementData(context: context)
			measurementData.systolicLevel = Int64(measurement.systolicLevel)
			measurementData.diastolicLevel = Int64(measurement.diastolicLevel)
			measurementData.date = measurement.date
			measurementData.id = measurement.id
			if let pulse = measurement.pulse {
				measurementData.pulse = Int64(pulse)
			}
			if let note = measurement.note {
				measurementData.note = note
			}
		}
		do {
			try context.save()
		} catch {
			print(error.localizedDescription)
		}
	}
	
//	static func loadAllMeasurements() -> [Measurement] {
//		let result = PersistenceController(inMemory: true)
//		let context = result.container.viewContext
//		measurement.forEach { measurement in
//			let measurementData = MeasurementData(context: context)
//			measurementData.systolicLevel = Int64(measurement.systolicLevel)
//			measurementData.diastolicLevel = Int64(measurement.diastolicLevel)
//			measurementData.date = measurement.date
//			measurementData.id = measurement.id
//			if let pulse = measurement.pulse {
//				measurementData.pulse = Int64(pulse)
//			}
//			if let note = measurement.note {
//				measurementData.note = note
//			}
//		}
//		do {
//			try context.save()
//		} catch {
//			print(error.localizedDescription)
//		}
//	}

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Blood_pressure_level")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
			print(storeDescription)
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}

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
	
	static func convertAndSave(_ measurement: Measurement) {
		let result = PersistenceController.shared
		let context = result.container.viewContext
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
		do {
			try context.save()
		} catch {
			print(error.localizedDescription)
		}
	}

	static func convertAndEdit(_ measurement: Measurement) {
		let result = PersistenceController.shared
		let context = result.container.viewContext
		let fetchRequest: NSFetchRequest<MeasurementData> = MeasurementData.fetchRequest()
		fetchRequest.predicate = NSPredicate(format: "id == %@", measurement.id as CVarArg)
		do {
			let results = try context.fetch(fetchRequest)
			if let measurementToEdit = results.first {
				measurementToEdit.systolicLevel = Int64(measurement.systolicLevel)
				measurementToEdit.diastolicLevel = Int64(measurement.diastolicLevel)
				if let pulse = measurement.pulse {
					measurementToEdit.pulse = Int64(pulse)
				}
				if let note = measurement.note {
					measurementToEdit.note = note
				}
				try context.save()
			}
		} catch {
			print("Edit error \(error.localizedDescription)")
		}
	}


    init() {
        container = NSPersistentContainer(name: "Blood_pressure_level")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}

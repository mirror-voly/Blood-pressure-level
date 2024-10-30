//
//  DataStore.swift
//  Blood pressure level
//
//  Created by mix on 26.10.2024.

import SwiftUI
import CoreData

final class DataStore: NSObject, ObservableObject {
	
	static let shared = DataStore(context: PersistenceController.shared.container.viewContext)
	
	@Published private(set) var measurements: [Measurement] = []
	
	private var fetchedResultsController: NSFetchedResultsController<MeasurementData>
	
	// Инициализатор, принимающий NSManagedObjectContext
	init(context: NSManagedObjectContext) {
		// Инициализация NSFetchedResultsController
		let fetchRequest: NSFetchRequest<MeasurementData> = MeasurementData.fetchRequest()
		fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
		
		fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
		
		super.init() // Вызов инициализатора родительского класса
		
		do {
			try fetchedResultsController.performFetch()
			updateFetch()
		} catch {
			print("Ошибка при выполнении fetch: \(error)")
		}
		
		// Подписка на изменения
		fetchedResultsController.delegate = self
	}
	
	// Метод для обновления массива measurements
	private func updateFetch() {
		guard let fetchedResults = fetchedResultsController.fetchedObjects else { return }
		
		measurements = fetchedResults.map { result in
			Measurement(
				systolicLevel: Int(result.systolicLevel),
				diastolicLevel: Int(result.diastolicLevel),
				id: result.id ?? UUID(),
				date: result.date ?? Date(),
				pulse: result.pulse == 0 ? nil : Int(result.pulse),
				note: result.note == Constants.General.emptyString ? nil : result.note
			)
		}
	}
	
	// Метод для добавления или редактирования измерения
	func addOrEditMeasurement(_ measurement: Measurement, forEdit: Bool) {
		if forEdit {
			PersistenceController.convertAndEdit(measurement) 
		} else {
			PersistenceController.convertAndSave(measurement)
		}
	}
}

// MARK: - NSFetchedResultsControllerDelegate
extension DataStore: NSFetchedResultsControllerDelegate {
	
	// Реализация метода делегата для обновления данных
	func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
		updateFetch()
	}
}


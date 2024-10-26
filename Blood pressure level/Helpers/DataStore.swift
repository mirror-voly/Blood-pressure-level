//
//  DataStore.swift
//  Blood pressure level
//
//  Created by mix on 26.10.2024.
//

import Foundation

final class DataStore: ObservableObject {
	static let shared = DataStore()
	
	@Published var measurements: [Measurement] = []
	
	private init() {}
}

//
//  AddMeasurementTip.swift
//  Blood pressure level
//
//  Created by mix on 24.10.2024.
//

import Foundation
import TipKit

struct AddMeasurementTip: Tip, Identifiable {
	var id = UUID()
	var title: Text {
		Text("Add measurement")
	}
	
	var message: Text? {
		Text("hi")
	}
	
}

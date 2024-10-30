//
//  DatePrepare.swift
//  Blood pressure level
//
//  Created by mix on 29.10.2024.
//

import SwiftUI

final class DatePrepare {
	
	static func getFormatedDate(date: Date, displayedComponents: DatePickerComponents) -> String {
		let formattedDate: String
		if displayedComponents == .hourAndMinute {
			formattedDate = date.formatted(.dateTime.hour().minute())
		} else {
			formattedDate = date.formatted(date: .numeric, time: .omitted)
		}
		return formattedDate
	}
	
	static func formatDate(date: Date, formatStyle: PresentationPeriod) -> String {
		if formatStyle == .day {
			date.formatted(.dateTime.hour().minute()).localizedCapitalized
		} else {
			date.formatted(.dateTime.year().month().day()).localizedCapitalized
		}
	}
}

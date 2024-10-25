//
//  DateFieldView.swift
//  Blood pressure level
//
//  Created by mix on 25.10.2024.
//

import SwiftUI

struct DateFieldView: View {
	
	private let currentDate = Date()
	let displayedComponents: DatePickerComponents
	@Binding var date: Date

	private var didChange: Bool {
		if displayedComponents == .hourAndMinute {
			return date.formatted(.dateTime.hour().minute()) != currentDate.formatted(.dateTime.hour().minute())
		} else {
			return date.formatted(.dateTime.year().month().day()) != currentDate.formatted(.dateTime.year().month().day())
		}
	}

	func takeDate() -> String {
		let formattedDate: String
		if displayedComponents == .hourAndMinute {
			formattedDate = date.formatted(.dateTime.hour().minute())
		} else {
			formattedDate = date.formatted(date: .numeric, time: .omitted)
		}
		return formattedDate
	}
	
    var body: some View {
		ZStack(alignment: .leading, content: {
			DatePicker(Constants.General.emptyString,
					   selection: $date,
					   in: currentDate...,
					   displayedComponents: displayedComponents)
			.datePickerStyle(.compact)
			.fixedSize()

			Text(takeDate())
				.font(.system(size: Constants.FontSize.big))
				.padding()
				.foregroundStyle(didChange ? .main : .secondaryGrayDark)
				.frame(maxWidth: .infinity, alignment: .leading)
				.background(Color.scheme)
				.clipShape(RoundedRectangle(cornerRadius: Constants.Radius.small))
				.allowsHitTesting(false)
		})
    }
}


//
//  DateFields.swift
//  Blood pressure level
//
//  Created by mix on 25.10.2024.
//

import SwiftUI

struct DateFields: View {
	
	@Binding var date: Date
	
    var body: some View {
		HStack {
			VStack(alignment: .leading)  {
				Text("Дата измерений")
					.font(.system(size: Constants.FontSize.regular))
				
				DateFieldView(displayedComponents: .date, date: $date)
			}
			
			VStack(alignment: .leading) {
				Text("Время измерений")
					.font(.system(size: Constants.FontSize.regular))
				
				DateFieldView(displayedComponents: .hourAndMinute, date: $date)
			}
		}
    }
}


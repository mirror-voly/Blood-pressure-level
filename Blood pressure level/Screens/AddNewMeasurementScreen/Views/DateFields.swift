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
				Text("date_of_measurement".localized)
					.font(.system(size: Constants.FontSize.regular))
				
				DateFieldView(displayedComponents: .date, date: $date)
			}
			
			VStack(alignment: .leading) {
				Text("time_of_measurement".localized)
					.font(.system(size: Constants.FontSize.regular))
				
				DateFieldView(displayedComponents: .hourAndMinute, date: $date)
			}
		}
    }
}


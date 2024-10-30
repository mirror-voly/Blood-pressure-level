//
//  DateFields.swift
//  Blood pressure level
//
//  Created by mix on 25.10.2024.
//

import SwiftUI

struct DateFields: View {
	
    var body: some View {
		HStack {
			VStack(alignment: .leading, spacing: Constants.Spacing.small)  {
				Text("date_of_measurement".localized)
					.font(.system(size: Constants.FontSize.regular))
				
				DateFieldView(displayedComponents: .date)
			}
			
			VStack(alignment: .leading, spacing: Constants.Spacing.small) {
				Text("time_of_measurement".localized)
					.font(.system(size: Constants.FontSize.regular))
				
				DateFieldView(displayedComponents: .hourAndMinute)
			}
		}
    }
}


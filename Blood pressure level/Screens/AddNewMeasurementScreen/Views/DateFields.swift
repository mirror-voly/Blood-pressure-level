//
//  DateFields.swift
//  Blood pressure level
//
//  Created by mix on 25.10.2024.
//

import SwiftUI

struct DateFields: View {
	
	@StateObject var viewModel: AddNewMeasurementViewModel
	
    var body: some View {
		HStack {
			VStack(alignment: .leading)  {
				Text("date_of_measurement".localized)
					.font(.system(size: Constants.FontSize.regular))
				
				DateFieldView(viewModel: viewModel, displayedComponents: .date)
			}
			
			VStack(alignment: .leading) {
				Text("time_of_measurement".localized)
					.font(.system(size: Constants.FontSize.regular))
				
				DateFieldView(viewModel: viewModel, displayedComponents: .hourAndMinute)
			}
		}
    }
}


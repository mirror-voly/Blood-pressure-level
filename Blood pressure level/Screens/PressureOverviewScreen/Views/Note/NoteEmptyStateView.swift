//
//  NoteEmptyStateView.swift
//  Blood pressure level
//
//  Created by mix on 29.10.2024.
//

import SwiftUI

struct NoteEmptyStateView: View {
	
	@StateObject var viewModel: PressureOverviewViewModel
	
    var body: some View {
		Group {
			Divider()
			
			Text("describe_your_condition".localized)
				.font(.system(size: Constants.FontSize.small))
				.foregroundStyle(.secondaryGrayDark)
				.frame(maxWidth: .infinity, alignment: .leading)
				.padding(.vertical, Constants.Padding.micro)
		}
    }
}

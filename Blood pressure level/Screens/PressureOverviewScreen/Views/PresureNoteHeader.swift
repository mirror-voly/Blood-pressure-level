//
//  PresureNoteHeader.swift
//  Blood pressure level
//
//  Created by mix on 28.10.2024.
//

import SwiftUI

struct PresureNoteHeader: View {
	
	@StateObject var viewModel: PressureOverviewViewModel
	
    var body: some View {
		HStack(alignment: .top, spacing: Constants.Spacing.defaultSpacing) {
			Image("note")
			Text("notes".localized)
				.font(.system(size: Constants.FontSize.regular))
				.bold()
			
			Spacer()
			
			Button(action: {
				viewModel.addNewScreenIsPresented = true
			}) {
				Image(systemName: viewModel.measurementsWithNotes.isEmpty ? "plus" : "chevron.right")
					.font(.system(size: Constants.FontSize.large))
					.fontWeight(.light)
					.foregroundStyle(.main.opacity(Constants.Opacity.regular))
			}
		}
		.frame(maxHeight: Constants.FrameSize.presureNoteViewHeaderHeight)
    }
}

//
//  PresureNoteHeader.swift
//  Blood pressure level
//
//  Created by mix on 28.10.2024.
//

import SwiftUI

struct PresureNoteHeader: View {
	
	@EnvironmentObject private var viewModel: PressureOverviewViewModel
	
	var body: some View {
		HStack(alignment: .top, spacing: Constants.Spacing.regular) {
			Image("note")
			Text("notes".localized)
				.font(.system(size: Constants.FontSize.regular))
				.bold()
			
			Spacer()
			
			Button(action: {
				if viewModel.measurementsWithNote.isEmpty {
					viewModel.addNewScreenIsPresented = true	
				}
			}) {
				Image(systemName: viewModel.measurementsWithNote.isEmpty ? "plus" : "chevron.right")
					.font(.system(size: Constants.FontSize.regular))
					.fontWeight(.light)
					.foregroundStyle(.main.opacity(Constants.Opacity.regular))
			}
		}
		.frame(maxHeight: Constants.FrameSize.presureNoteViewHeaderHeight)
	}
}

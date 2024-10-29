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
				if viewModel.measurementsWithNotes.isEmpty {
					viewModel.addNewScreenIsPresented = true	
				} else {
					viewModel.isNoteViewOpened.toggle()
				}
			}) {
				Image(systemName: viewModel.measurementsWithNotes.isEmpty ? "plus" : "chevron.right")
					.rotationEffect(Angle(degrees: viewModel.isNoteViewOpened ? 90 : 0))
					.font(.system(size: Constants.FontSize.regular))
					.fontWeight(.light)
					.foregroundStyle(.main.opacity(Constants.Opacity.regular))
			}
		}
		.frame(maxHeight: Constants.FrameSize.presureNoteViewHeaderHeight)
    }
}

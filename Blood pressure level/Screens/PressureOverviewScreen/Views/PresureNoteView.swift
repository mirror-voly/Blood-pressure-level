//
//  PresureNoteView.swift
//  Blood pressure level
//
//  Created by mix on 24.10.2024.
//

import SwiftUI

struct PresureNoteView: View {
	
	@StateObject var viewModel: PressureOverviewViewModel
	
	var body: some View {
		VStack(alignment: .leading, spacing: Constants.Spacing.smallSpacing) {
			VStack {
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
				
				if viewModel.measurementsWithNotes.count == 1 {
					Divider()
					
					NoteView(noteInfo: viewModel.firstNoteInfo)
					
				} else if viewModel.measurementsWithNotes.isEmpty {
					Divider()
					
					Text("describe_your_condition".localized)
						.font(.system(size: Constants.FontSize.small))
						.foregroundStyle(.secondaryGrayDark)
						.frame(maxWidth: .infinity, alignment: .leading)
						.padding(.vertical, Constants.Padding.micro)
				}
			}
			.padding()	
		}
		.background(.scheme)
		.clipShape(RoundedRectangle(cornerRadius: Constants.Radius.big))
	}
}

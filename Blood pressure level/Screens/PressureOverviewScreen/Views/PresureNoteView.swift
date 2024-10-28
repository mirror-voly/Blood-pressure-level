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
				PresureNoteHeader(viewModel: viewModel)
				
				if let note = viewModel.noteForPresent {
					Divider()
					
					NoteView(noteInfo: note)
					
					
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

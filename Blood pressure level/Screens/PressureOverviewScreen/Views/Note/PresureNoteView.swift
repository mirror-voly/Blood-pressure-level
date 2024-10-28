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
		VStack(alignment: .leading, spacing: Constants.Spacing.small) {
			VStack {
				PresureNoteHeader(viewModel: viewModel)
				
				if viewModel.measurementsWithNotes.isEmpty {
					NoteEmptyStateView(viewModel: viewModel)
				} else {
					NoteList(viewModel: viewModel)
				}
			}
			.padding()	
		}
		.background(.scheme)
		.clipShape(RoundedRectangle(cornerRadius: Constants.Radius.big))
		.frame(maxHeight: Constants.FrameSize.presureNoteViewMaxHeight, alignment: .top)
	}
}

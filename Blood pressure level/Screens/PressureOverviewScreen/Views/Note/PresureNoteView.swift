//
//  PresureNoteView.swift
//  Blood pressure level
//
//  Created by mix on 24.10.2024.
//

import SwiftUI

struct PresureNoteView: View {
	
	@EnvironmentObject private var viewModel: PressureOverviewViewModel
	
	var body: some View {
		VStack(alignment: .leading, spacing: Constants.Spacing.small) {
			VStack {
				PresureNoteHeader()
				
				if viewModel.measurementsWithNotes.isEmpty {
					NoteEmptyStateView()
				} else {
					NoteList()
				}
			}
			.padding()	
		}
		.background(.scheme)
		.clipShape(RoundedRectangle(cornerRadius: Constants.Radius.big))
		.frame(maxHeight: Constants.FrameSize.presureNoteViewMaxHeight, alignment: .top)
	}
}

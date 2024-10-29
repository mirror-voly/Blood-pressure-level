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
					emptyStateView()
				} else {
					notesView()
				}
			}
			.padding()	
		}
		.background(.scheme)
		.clipShape(RoundedRectangle(cornerRadius: Constants.Radius.big))
		.frame(maxHeight: Constants.FrameSize.presureNoteViewMaxHeight, alignment: .top)
	}
}

extension PresureNoteView {
	@ViewBuilder
	func notesView() -> some View {
		if let note = viewModel.selectedMessurment?.note, !note.isEmpty {
			ScrollView {
				ForEach(note, id: \.?.time) { noteInfo in
					if let noteInfo = noteInfo {
						NoteView(noteInfo: noteInfo)
					}
				}
			}
		} else if viewModel.measurementsWithNotes.count == 1, let noteInfo = viewModel.getNoteInfo() {
			ScrollView {
				NoteView(noteInfo: noteInfo)
			}
		}
	}

	func emptyStateView() -> some View {
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

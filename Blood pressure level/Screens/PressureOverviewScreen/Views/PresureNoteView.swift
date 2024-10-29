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
				
				if let note = viewModel.selectedMessurment?.note {
					ScrollView { 
						ForEach(note, id: \.?.time) { noteInfo in
							
							Divider()
							
							if let noteInfo = noteInfo {
								NoteView(noteInfo: noteInfo)
							}
							
						}
					}
					
	
				} else if viewModel.measurementsWithNotes.count == 1 {
					if let noteInfo = viewModel.getNoteInfo() {
						NoteView(noteInfo: noteInfo)
					}
					
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
		.frame(maxHeight: 120, alignment: .top)
	}
}

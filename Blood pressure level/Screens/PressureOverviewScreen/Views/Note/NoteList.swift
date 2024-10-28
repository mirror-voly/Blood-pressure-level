//
//  NoteList.swift
//  Blood pressure level
//
//  Created by mix on 29.10.2024.
//

import SwiftUI

struct NoteList: View {
	
	@StateObject var viewModel: PressureOverviewViewModel
	
    var body: some View {
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
}


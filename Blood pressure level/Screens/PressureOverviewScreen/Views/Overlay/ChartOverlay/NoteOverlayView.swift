//
//  NoteOverlayView.swift
//  Blood pressure level
//
//  Created by mix on 29.10.2024.
//

import SwiftUI

struct NoteOverlayView: View {
    var body: some View {
		HStack {
			Image(systemName: "circle")
				.resizable()
				.bold()
				.foregroundStyle(.blue)
				.frame(width: Constants.FrameSize.overlaySelectionNoteIconSize,
					   height: Constants.FrameSize.overlaySelectionNoteIconSize)
			
			Text("there_are_notes".localized)
				.font(.system(size: Constants.FontSize.verySmall))
				.foregroundStyle(.main.opacity(Constants.Opacity.big))
		}
		.frame(height: Constants.FrameSize.overlaySelectionNoteIconSize)
    }
}

#Preview {
    NoteOverlayView()
}

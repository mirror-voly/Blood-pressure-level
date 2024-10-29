//
//  NoteView.swift
//  Blood pressure level
//
//  Created by mix on 28.10.2024.
//

import SwiftUI

struct NoteView: View {

	let noteInfo: (time: String, text: String)
	
	var body: some View {
		
		Divider()
		VStack(alignment: .leading, spacing: 0) {
			Text(noteInfo.time)
				.font(.system(size: Constants.FontSize.verySmall))
				.foregroundStyle(.main.opacity(0.3))
			
			Text(noteInfo.text)
				.font(.system(size: Constants.FontSize.small))
				.foregroundStyle(.main)
				.frame(maxWidth: .infinity, alignment: .leading)
				.padding(.vertical, Constants.Padding.micro)
		}
	}
}

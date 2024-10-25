//
//  PresureNoteView.swift
//  Blood pressure level
//
//  Created by mix on 24.10.2024.
//

import SwiftUI

struct PresureNoteView: View {
    var body: some View {
		VStack(alignment: .leading, spacing: 8, content: {
			VStack(content: {
				HStack(alignment: .top, spacing: 16) {
					Image("note")
					Text("Заметки")
						.font(.system(size: 16))
						.bold()
					
					Spacer()
					
					Button(action: {
						
					}, label: {
						Image(systemName: "plus")
							.font(.system(size: 24))
							.fontWeight(.light)
							.foregroundStyle(.main.opacity(0.3))
					})
				}
				.frame(maxHeight: 24)
				
				Divider()
				
				VStack(alignment: .leading) {
					Text("Опиши своё состояние")
						.font(.system(size: 14))
						.foregroundStyle(.secondaryGrayDark)
						.frame(maxWidth: .infinity, alignment: .leading)
						.padding(.vertical, 4)
				}
			})
			.padding()
			
		})
		.background(.scheme)
		.clipShape(RoundedRectangle(cornerRadius: 24))
    }
}

#Preview {
    PresureNoteView()
}

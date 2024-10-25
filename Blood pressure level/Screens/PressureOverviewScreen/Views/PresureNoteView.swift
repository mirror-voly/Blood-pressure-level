//
//  PresureNoteView.swift
//  Blood pressure level
//
//  Created by mix on 24.10.2024.
//

import SwiftUI

struct PresureNoteView: View {
    var body: some View {
		VStack(alignment: .leading, spacing: Constants.Spacing.smallSpacing, content: {
			VStack(content: {
				HStack(alignment: .top, spacing: Constants.Spacing.defaultSpacing) {
					Image("note")
					Text("notes".localized)
						.font(.system(size: Constants.FontSize.regular))
						.bold()
					
					Spacer()
					
					Button(action: {
						
					}, label: {
						Image(systemName: "plus")
							.font(.system(size: Constants.FontSize.large))
							.fontWeight(.light)
							.foregroundStyle(.main.opacity(Constants.Opacity.regular))
					})
				}
				.frame(maxHeight: Constants.FrameSize.presureNoteViewHearerHeight)
				
				Divider()
				
				VStack(alignment: .leading) {
					Text("describe_your_condition".localized)
						.font(.system(size: Constants.FontSize.small))
						.foregroundStyle(.secondaryGrayDark)
						.frame(maxWidth: .infinity, alignment: .leading)
						.padding(.vertical, Constants.Padding.micro)
				}
			})
			.padding()
			
		})
		.background(.scheme)
		.clipShape(RoundedRectangle(cornerRadius: Constants.Radius.big))
    }
}

#Preview {
    PresureNoteView()
}

//
//  PresureOverviewHeaderView.swift
//  Blood pressure level
//
//  Created by mix on 23.10.2024.
//

import SwiftUI

struct PresureOverviewHeaderView: View {
	
	@Binding var addNewScreenIsPresented: Bool
	
	var body: some View {
		VStack(alignment: .center, spacing: Constants.Spacing.defaultSpacing) {
				HStack(alignment: .center, content: {
					Image("logo")
						.renderingMode(.template)
						.foregroundStyle(.primary)
					
					Text("Мой доктор")
						.font(.system(size: Constants.FontSize.regular))
				})
				
				ZStack(alignment: .center, content: {
					VStack(content: {
						Text("Давление")
							.font(.system(size: Constants.FontSize.big))
							.bold()
						
						let formattedDate = Date.now.formatted(.dateTime.month().year())
						Text(formattedDate + " " + "г.")
							.font(.system(size: Constants.FontSize.small))
					})
					
					Button(action: {
						addNewScreenIsPresented = true
					}, label: {
						ZStack(content: {
							RoundedRectangle(cornerRadius: Constants.Button.buttonCornerRadius)
								.fill(.scheme)
								.frame(width: Constants.Button.buttonHeight,
									   height: Constants.Button.buttonHeight)

							Image(systemName: "plus")
								.tint(.primary)
								.font(.system(size: Constants.FontSize.large))
								.fontWeight(.light)
						})						
					})
					.frame(maxWidth: .infinity, alignment: .trailing)
					
				})
			}
	}
}

#Preview {
	PresureOverviewHeaderView(addNewScreenIsPresented: .constant(true))
}

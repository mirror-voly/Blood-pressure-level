//
//  PresureOverviewHeaderView.swift
//  Blood pressure level
//
//  Created by mix on 23.10.2024.
//

import SwiftUI

struct PresureOverviewHeaderView: View {
	var body: some View {
			VStack(alignment: .center, spacing: 16) {
				HStack(alignment: .center, content: {
					Image("logo")
						.renderingMode(.template)
						.foregroundStyle(.primary)
					Text("Мой доктор")
						.font(.system(size: 16))
				})
				ZStack(alignment: .center, content: {
					VStack(spacing: 2, content: {
						Text("Давление")
							.font(.system(size: 18))
							.bold()
						let formattedDate = Date.now.formatted(.dateTime.month().year())
						Text(formattedDate + " " + "г.")
							.font(.system(size: 14))
					})
					Button(action: {
						
					}, label: {
						ZStack(content: {
							RoundedRectangle(cornerRadius: 10)
								.fill(.scheme)
								.frame(width: 32, height: 32)
							Image(systemName: "plus")
								.tint(.primary)
								.font(.system(size: 24))
								.fontWeight(.light)
						})						
					})
					.frame(maxWidth: .infinity, alignment: .trailing)
				})
			}
	}
}

#Preview {
    PresureOverviewHeaderView()
}

//
//  PresureOverviewHeaderView.swift
//  Blood pressure level
//
//  Created by mix on 23.10.2024.
//

import SwiftUI
import RxSwift

struct PresureOverviewHeaderView: View {
	
	@StateObject var viewModel: PressureOverviewViewModel
	
	var body: some View {
		VStack(alignment: .center, spacing: Constants.Spacing.regular) {
			HStack(alignment: .center, content: {
				Image("logo")
					.renderingMode(.template)
					.foregroundStyle(.primary)
				
				Text("my_doctor".localized)
					.font(.system(size: Constants.FontSize.regular))
			})
			
			ZStack(alignment: .center, content: {
				VStack(content: {
					Text("pressure".localized)
						.font(.system(size: Constants.FontSize.big))
						.bold()
					
					Text(viewModel.formattedDate.localizedCapitalized)
						.font(.system(size: Constants.FontSize.small))
				})
				
				Button(action: {
					viewModel.addNewScreenIsPresented = true
				}, label: {
					ZStack(content: {
						RoundedRectangle(cornerRadius: Constants.Button.buttonCornerRadius)
							.fill(.scheme)
							.frame(width: Constants.Button.height,
								   height: Constants.Button.height)
						
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

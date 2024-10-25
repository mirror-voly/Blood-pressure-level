//
//  AddNewHeaderView.swift
//  Blood pressure level
//
//  Created by mix on 25.10.2024.
//

import SwiftUI

struct AddNewHeaderView: View {
	
	@Environment(\.dismiss) var dismiss
	
    var body: some View {
		ZStack {
			Button {
				dismiss()
			} label: {
				RoundedRectangle(cornerRadius: Constants.Button.buttonCornerRadius)
					.fill(.scheme)
					.frame(width: Constants.Button.height, height: Constants.Button.height)
					.overlay(Image(systemName: "chevron.backward"))
			}
			.foregroundStyle(.main)
			.frame(maxWidth: .infinity, alignment: .leading)
			
			Text("Добавить данные")
				.font(.system(size: Constants.FontSize.big))
				.bold()
				.frame(maxWidth: .infinity, alignment: .center)
			
		}
    }
}

#Preview {
    AddNewHeaderView()
}

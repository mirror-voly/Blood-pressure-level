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
				RoundedRectangle(cornerRadius: 10)
					.fill(.scheme)
					.frame(width: 32, height: 32)
					.overlay(Image(systemName: "chevron.backward"))
			}
			.foregroundStyle(.main)
			.frame(maxWidth: .infinity, alignment: .leading)
			
			Text("Добавить данные")
				.font(.system(size: 18))
				.bold()
				.frame(maxWidth: .infinity, alignment: .center)
			
		}
    }
}

#Preview {
    AddNewHeaderView()
}

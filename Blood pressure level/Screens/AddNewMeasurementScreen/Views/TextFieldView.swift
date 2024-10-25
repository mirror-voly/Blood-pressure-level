//
//  TextFieldView.swift
//  Blood pressure level
//
//  Created by mix on 25.10.2024.
//

import SwiftUI

struct TextFieldView: View {
	
	let placeholder: String
	@Binding var text: String
	@State var isOnChange = false
	
	var body: some View {
		TextField("", text: $text, onEditingChanged: { edit in
			isOnChange = edit
		})
		.font(.system(size: 18))
		.padding()
		.background(Color.scheme)
		.clipShape(RoundedRectangle(cornerRadius: 14))
		.placeholder(when: text.isEmpty) { Text(placeholder) }
		.overlay(
			Group {
				if isOnChange {
					RoundedRectangle(cornerRadius: 14)
						.stroke(.main, lineWidth: 1)
				}
			}
		)
	}
}

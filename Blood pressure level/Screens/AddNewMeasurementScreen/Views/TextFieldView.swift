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
		TextField(Constants.General.emptyString,
				  text: $text, onEditingChanged: { edit in
			isOnChange = edit
		})
		.font(.system(size: Constants.FontSize.big))
		.padding()
		.background(Color.scheme)
		.clipShape(RoundedRectangle(cornerRadius: Constants.Radius.small))
		.placeholder(when: text.isEmpty) { Text(placeholder) }
		.overlay(
			Group {
				if isOnChange {
					RoundedRectangle(cornerRadius: Constants.Radius.small)
						.stroke(.main, lineWidth: Constants.General.originalValue)
				}
			}
		)
	}
}

//
//  PressureChartsView.swift
//  Blood pressure level
//
//  Created by mix on 24.10.2024.
//

import SwiftUI

struct PressureChartsView: View {
	
	@Binding var addNewScreenIsPresented: Bool

    var body: some View {
		VStack(alignment: .leading, spacing: Constants.Spacing.defaultSpacing) {
			HStack(content: {
				Text("Нет данных")
					.font(.system(size: Constants.FontSize.big))
					.bold()
				Spacer()
			})

			HStack {
				Text("Сегодня")
					.font(.system(size: Constants.FontSize.big))
			}

			Divider()

			HStack(spacing: Constants.Spacing.defaultSpacing) {
				Group {
					Circle()
						.fill(.systolic)
					
					Text("Систолическое")
					
					Circle()
						.fill(.diastolic)

					Text("Диастолическое")
				}
				.frame(height: 8)
				.font(.system(size: Constants.FontSize.micro))

				Spacer()
			}
			
			VStack {
			}
			.frame(maxWidth: .infinity, maxHeight: 215)
			
			Spacer()
			
			Button(action: {
				addNewScreenIsPresented = true
			}, label: {
				Text("Добавить данные")
					.font(.system(size: Constants.FontSize.micro))
					.padding(.vertical, 8)
					.padding(.horizontal, 16)
					.foregroundStyle(.systolic)
					.background(.scheme)
					.clipShape(.capsule)
					.buttonBorderShape(.capsule)
					.overlay(
						RoundedRectangle(cornerRadius: Constants.Radius.regular)
							.stroke(.systolic, lineWidth: 1))
			})
			.frame(maxWidth: .infinity, alignment: .bottomTrailing)

		}
		.padding(.horizontal)
		.padding(.vertical, 20)
		.background(.scheme)
		.frame(maxWidth: .infinity, maxHeight: 397)
		.clipShape(RoundedRectangle(cornerRadius: Constants.Radius.big))
    }
}

#Preview {
	PressureChartsView(addNewScreenIsPresented: .constant(true))
}

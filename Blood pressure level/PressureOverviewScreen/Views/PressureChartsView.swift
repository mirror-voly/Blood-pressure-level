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
		VStack(alignment: .leading, spacing: 16) {
			HStack(content: {
				Text("Нет данных")
					.font(.system(size: 18))
					.bold()
				Spacer()
			})

			HStack {
				Text("Сегодня")
					.font(.system(size: 10))
			}

			Divider()

			HStack(spacing: 16) {
				Group {
					Circle()
						.fill(.systolic)
					
					Text("Систолическое")
					
					Circle()
						.fill(.diastolic)

					Text("Диастолическое")
				}
				.frame(height: 8)
				.font(.system(size: 12))

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
					.font(.system(size: 12))
					.padding(.vertical, 8)
					.padding(.horizontal, 16)
					.foregroundStyle(.systolic)
					.background(.scheme)
					.clipShape(.capsule)
					.buttonBorderShape(.capsule)
					.overlay(
						RoundedRectangle(cornerRadius: 16)
							.stroke(.systolic, lineWidth: 1))
			})
			.frame(maxWidth: .infinity, alignment: .bottomTrailing)

		}
		.padding(.horizontal)
		.padding(.vertical, 20)
		.background(.scheme)
		.frame(maxWidth: .infinity, maxHeight: 397)
		.clipShape(RoundedRectangle(cornerRadius: 24))
    }
}

#Preview {
	PressureChartsView(addNewScreenIsPresented: .constant(true))
}
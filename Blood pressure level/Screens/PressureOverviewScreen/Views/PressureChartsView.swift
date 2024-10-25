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
				.frame(height: Constants.FrameSize.chartLegendHeight)
				.font(.system(size: Constants.FontSize.micro))

				Spacer()
			}
			
			VStack {
			}
			.frame(maxWidth: .infinity, maxHeight: Constants.FrameSize.chartHeight)
			
			Spacer()
			
			Button(action: {
				addNewScreenIsPresented = true
			}, label: {
				Text("Добавить данные")
					.font(.system(size: Constants.FontSize.micro))
					.padding(.vertical, Constants.Padding.small)
					.padding(.horizontal, Constants.Padding.regular)
					.foregroundStyle(.systolic)
					.background(.scheme)
					.clipShape(.capsule)
					.buttonBorderShape(.capsule)
					.overlay(
						RoundedRectangle(cornerRadius: Constants.Radius.regular)
							.stroke(.systolic, lineWidth: Constants.General.originalValue))
			})
			.frame(maxWidth: .infinity, alignment: .bottomTrailing)

		}
		.padding(.horizontal)
		.padding(.vertical, Constants.Padding.big)
		.background(.scheme)
		.frame(maxWidth: .infinity, maxHeight: Constants.FrameSize.wholeChartViewHeight )
		.clipShape(RoundedRectangle(cornerRadius: Constants.Radius.big))
    }
}

#Preview {
	PressureChartsView(addNewScreenIsPresented: .constant(true))
}

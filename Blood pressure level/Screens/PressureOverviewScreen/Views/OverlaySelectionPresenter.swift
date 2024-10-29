//
//  OverlaySelectionPresenter.swift
//  Blood pressure level
//
//  Created by mix on 28.10.2024.
//

import SwiftUI

struct OverlaySelectionPresenter: View {
	
	@StateObject var viewModel: PressureOverviewViewModel
	
	var body: some View {
		if let selectedMessurment = viewModel.selectedMessurment {
			VStack(spacing: .zero, content: {
				HStack(alignment: .top, spacing: Constants.Spacing.defaultSpacing) {
					VStack(alignment: .leading, spacing: 16, content: {
						VStack(alignment: .leading, content: {
							Text("systolic".localized)
								.font(.system(size: 12))
								.foregroundStyle(.main.opacity(0.5))
								.frame(width: 58, alignment: .leading)
							
							Group {
								if let systolicLevelsMin = selectedMessurment.systolicLevelsMin {
									Text("\(systolicLevelsMin) - \(selectedMessurment.systolicLevelsMax)")
								} else {
									Text("\(selectedMessurment.systolicLevelsMax)")
								}
							}
								.font(.system(size: Constants.FontSize.big))
								.bold()
							
							Text("mmHg".localized)
								.font(.system(size: 12))
								.foregroundStyle(.main.opacity(0.5))
						})
						
						VStack(alignment: .leading, content: {
							if let pulseMax = selectedMessurment.pulseMax {
								Text("pulse".localized)
									.font(.system(size: 12))
									.foregroundStyle(.main.opacity(0.5))
									.frame(width: 58, alignment: .leading)
								
								Group {
									if let pulseMin = selectedMessurment.pulseMin {
											Text("\(pulseMin) - \(pulseMax)")
									} else {
											Text("\(pulseMax)")
									}
								}
									.font(.system(size: Constants.FontSize.big))
									.bold()
								
								Text("bpm".localized)
									.font(.system(size: 12))
									.foregroundStyle(.main.opacity(0.5))
							}
						})
					})
					
					VStack(alignment: .leading, spacing: 16, content: {
						VStack(alignment: .leading, content: {
							Text("diastolic".localized)
								.font(.system(size: 12))
								.foregroundStyle(.main.opacity(0.5))
								.frame(width: 58, alignment: .leading)
							
							Group {
								if let diastolicLevelMin = selectedMessurment.diastolicLevelMin {
									Text("\(diastolicLevelMin) - \(selectedMessurment.diastolicLevelMax)")
								} else {
									Text("\(selectedMessurment.diastolicLevelMax)")
								}
							}
								.font(.system(size: Constants.FontSize.big))
								.bold()
							
							Text("mmHg".localized)
								.font(.system(size: 12))
								.foregroundStyle(.main.opacity(0.5))
						})
						
						Spacer()
						
						VStack(alignment: .leading, content: {
	
							Text(selectedMessurment.date)
								.font(.system(size: Constants.FontSize.micro))
							
							HStack {
								let note = selectedMessurment.note.first
								
								if note != nil {
									Image(systemName: "circle")
										.resizable()
										.bold()
										.foregroundStyle(.blue)
										.frame(width: 6, height: 6)
								}
								
								Text(note != nil ? "there_are_notes".localized : "no_notes".localized)
									.font(.system(size: 12))
									.foregroundStyle(.main.opacity(0.5))
							}
							.frame(height: 7)
						})
					})
				}
				.padding()
				.background(.backgroundMain)
				.clipShape(RoundedRectangle(cornerRadius: Constants.Radius.regular))
				.overlay(
					RoundedRectangle(cornerRadius: 8)
						.stroke(.overlayBorder, lineWidth: Constants.General.originalValue)
				)
			})
			.frame(maxHeight: 142)
		}
			
	}
}

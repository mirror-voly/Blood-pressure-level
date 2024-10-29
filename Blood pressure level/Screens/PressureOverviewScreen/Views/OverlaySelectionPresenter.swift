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

			if let systolicLevelsMin = selectedMessurment.systolicLevelsMin {
				VStack(spacing: .zero, content: {
					HStack(alignment: .top, spacing: Constants.Spacing.regular) {
						VStack(alignment: .leading, spacing: Constants.Spacing.regular, content: {
							
							VStack(alignment: .leading, content: {
								Text("systolic".localized)
									.font(.system(size: Constants.FontSize.verySmall))
									.foregroundStyle(.main.opacity(Constants.Opacity.big))
									.frame(width: Constants.FrameSize.textItemWidth, alignment: .leading)
								
								Text("\(systolicLevelsMin) - \(selectedMessurment.systolicLevelsMax)")
									.font(.system(size: Constants.FontSize.big))
									.bold()
								
								Text("mmHg".localized)
									.font(.system(size: Constants.FontSize.verySmall))
									.foregroundStyle(.main.opacity(Constants.Opacity.big))
							})
							
							VStack(alignment: .leading, content: {
								if let pulseMax = selectedMessurment.pulseMax {
									Text("pulse".localized)
										.font(.system(size: Constants.FontSize.verySmall))
										.foregroundStyle(.main.opacity(Constants.Opacity.big))
										.frame(width: Constants.FrameSize.textItemWidth, alignment: .leading)
									
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
										.font(.system(size: Constants.FontSize.verySmall))
										.foregroundStyle(.main.opacity(Constants.Opacity.big))
								}
							})
						})
						
						VStack(alignment: .leading, spacing: Constants.Spacing.regular, content: {
							VStack(alignment: .leading, content: {
								Text("diastolic".localized)
									.font(.system(size: Constants.FontSize.verySmall))
									.foregroundStyle(.main.opacity(Constants.Opacity.big))
									.frame(width: Constants.FrameSize.textItemWidth, alignment: .leading)
								
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
									.font(.system(size: Constants.FontSize.verySmall))
									.foregroundStyle(.main.opacity(Constants.Opacity.big))
							})
							
							Spacer()
							
							VStack(alignment: .leading, content: {
								Text(selectedMessurment.date)
									.font(.system(size: Constants.FontSize.micro))
								
								if selectedMessurment.note.first != nil {
									noteView
								}
							})
							
						})
					}
					.padding()
					.background(.backgroundMain)
					.clipShape(RoundedRectangle(cornerRadius: Constants.Radius.regular))
					.overlay(
						RoundedRectangle(cornerRadius: Constants.Radius.verySmall)
							.stroke(.overlayBorder, lineWidth: Constants.General.originalValue)
					)
				})
				.frame(maxHeight: Constants.FrameSize.overlaySelectionFrameMaxHeight)
			} else {
				VStack(alignment: .center, spacing: Constants.Spacing.small, content: {
					HStack(alignment: .top, spacing: Constants.Spacing.regular) {
						
						VStack(alignment: .leading, spacing: Constants.Spacing.regular, content: {
							VStack(alignment: .leading, content: {
								Text("pressure".localized)
									.font(.system(size: Constants.FontSize.verySmall))
									.foregroundStyle(.main.opacity(Constants.Opacity.big))
								
								Text("\(selectedMessurment.systolicLevelsMax) / \(selectedMessurment.diastolicLevelMax)")
									.font(.system(size: Constants.FontSize.big))
									.bold()
								
								
								Text("mmHg".localized)
									.font(.system(size: Constants.FontSize.verySmall))
									.foregroundStyle(.main.opacity(Constants.Opacity.big))
							})
						})
						
						if let pulseMax = selectedMessurment.pulseMax {
							VStack(alignment: .leading, content: {
								Text("pulse".localized)
									.font(.system(size: Constants.FontSize.verySmall))
									.foregroundStyle(.main.opacity(Constants.Opacity.big))
								
								Text("\(pulseMax)")
									.font(.system(size: Constants.FontSize.big))
									.bold()
								
								Text("bpm".localized)
									.font(.system(size: Constants.FontSize.verySmall))
									.foregroundStyle(.main.opacity(Constants.Opacity.big))
							})
						}
					}

					VStack(alignment: .center, spacing: Constants.Spacing.verySmall) {
						// TODO: Change for "Today"
						Text(selectedMessurment.date)
							.font(.system(size: Constants.FontSize.micro))
						
						if selectedMessurment.note.first != nil {
							noteView
						}
					}
					
				})
				.padding()
				.background(.backgroundMain)
				.clipShape(RoundedRectangle(cornerRadius: Constants.Radius.regular))
				.overlay(
					RoundedRectangle(cornerRadius: Constants.Radius.verySmall)
						.stroke(.overlayBorder, lineWidth: Constants.General.originalValue)
				)
				.frame(maxHeight: Constants.FrameSize.overlaySelectionFrameMaxHeight)
			}
		}
	}
}


extension OverlaySelectionPresenter {
	var noteView: some View {
		HStack {
			Image(systemName: "circle")
				.resizable()
				.bold()
				.foregroundStyle(.blue)
				.frame(width: Constants.FrameSize.overlaySelectionNoteIconSize,
					   height: Constants.FrameSize.overlaySelectionNoteIconSize)
			
			Text("there_are_notes".localized)
				.font(.system(size: Constants.FontSize.verySmall))
				.foregroundStyle(.main.opacity(Constants.Opacity.big))
		}
		.frame(height: Constants.FrameSize.overlaySelectionNoteIconSize)
	}
}

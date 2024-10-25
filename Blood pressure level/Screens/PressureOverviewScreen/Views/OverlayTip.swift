//
//  OverlayTip.swift
//  Blood pressure level
//
//  Created by mix on 24.10.2024.
//

import SwiftUI

struct OverlayTip: View {
	
	@Binding var tipIsActive: Bool
	
    var body: some View {
		if tipIsActive {
			ZStack {
				Color.black.opacity(Constants.Opacity.regular)
					.ignoresSafeArea()
				
				VStack(spacing: .zero, content: {
					ZStack {
						Button(action: {
							withAnimation { 
								tipIsActive = false
							}
						}, label: {
							Image(systemName: "xmark.circle.fill")
								.resizable()
								.foregroundStyle(.secondaryGray)
								.fontWeight(.thin)
								.frame(width: Constants.FrameSize.tipButtonSize,
									   height: Constants.FrameSize.tipButtonSize)
						})
						.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
						
						VStack(spacing: Constants.Spacing.defaultSpacing) {
							Image("camera")
							
							Text("Добавьте данные")
								.font(.system(size: Constants.FontSize.big))
								.bold()

							Text("Добавить данные можно, кликнув на кнопку. Или попробуйте отсканировать данные на вашем аппарате.")
								.font(.system(size: Constants.FontSize.small))
								.multilineTextAlignment(.center) 
								.padding(.horizontal)
						}
					}
					.frame(width: Constants.FrameSize.tipBaseWidth,
						   height: Constants.FrameSize.tipBaseHeight)
					.padding()
					.background(.schemeForTips)
					.clipShape(RoundedRectangle(cornerRadius: Constants.Radius.regular))

					Triangle()
						.fill(.schemeForTips)
						.frame(width: Constants.FrameSize.tipTriangleSize,
							   height: Constants.FrameSize.tipTriangleSize)
						.rotationEffect(Angle(degrees: Constants.FrameSize.tipTriangleRotation))
						.frame(maxWidth: Constants.FrameSize.tipTriangleFrameWidth, alignment: .trailing)
				})
			}
		}
    }
}

#Preview {
	OverlayTip(tipIsActive: .constant(true))
}

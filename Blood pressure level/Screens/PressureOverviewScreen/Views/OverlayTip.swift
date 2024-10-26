//
//  OverlayTip.swift
//  Blood pressure level
//
//  Created by mix on 24.10.2024.
//

import SwiftUI

struct OverlayTip: View {
	
	@StateObject var viewModel: PressureOverviewViewModel
	
	var body: some View {
		ZStack {
			Color.black.opacity(Constants.Opacity.regular)
				.ignoresSafeArea()
			
			VStack(spacing: .zero, content: {
				ZStack {
					Button(action: {
						withAnimation { 
							viewModel.tipIsActive = false
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
						
						Text("add_data".localized)
							.font(.system(size: Constants.FontSize.big))
							.bold()
						
						Text("add_data_instruction".localized)
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

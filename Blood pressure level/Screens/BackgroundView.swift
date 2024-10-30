//
//  BackgroundView.swift
//  Blood pressure level
//
//  Created by mix on 24.10.2024.
//

import SwiftUI

struct BackgroundView: View {
	
	let backgroundType: BackgroundType
	
	var body: some View {
		ZStack {
			Color.backgroundMain
				.ignoresSafeArea()
			ZStack(alignment: .top) {
				Circle()
					.fill(.backgroundSecond.opacity(Constants.Background.circleMainColorOpacity))
					.frame(width: Constants.Background.circleMainSize,
						   height: Constants.Background.circleMainSize)
					.blur(radius: Constants.Background.circleMainBlurRadius)
				Circle()
					.fill(.backgroundFirst.opacity(Constants.Background.circleSecondColorOpacity))
					.frame(width: Constants.Background.circleSecondSize,
						   height: Constants.Background.circleSecondSize)
					.blur(radius: Constants.Background.circleSecondBlurRadius)
			}
			.rotationEffect(Angle(degrees: Constants.Background.angle))
			.frame(maxWidth: .infinity,
				   maxHeight: .infinity,
				   alignment: backgroundType == .mainScreen ? .topTrailing : .trailing)
			.padding(.trailing, Constants.Background.paddingTrailing)
			.padding(.top, Constants.Background.paddingTop)
		}
	}
}

#Preview {
	BackgroundView(backgroundType: .addNewScreen)
}

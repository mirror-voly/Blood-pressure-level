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
					.fill(.backgroundSecond.opacity(0.8))
					.frame(width: 138, height: 138)
					.blur(radius: 50)
				Circle()
					.fill(.backgroundFirst.opacity(0.7))
					.frame(width: 78, height: 78)
					.blur(radius: 25)
			}
			.rotationEffect(Angle(degrees: 45))
			.frame(maxWidth: .infinity,
				   maxHeight: .infinity,
				   alignment: backgroundType == .mainScreen ? .topTrailing : .trailing)
			.padding(.trailing, -50)
			.padding(.top, 50)
		}
	}
}

#Preview {
	BackgroundView(backgroundType: .addNewScreen)
}

enum BackgroundType {
	case mainScreen
	case addNewScreen
}

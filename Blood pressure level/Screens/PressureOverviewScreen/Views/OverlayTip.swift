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
				Color.black.opacity(0.3)
					.ignoresSafeArea()
				
				VStack(spacing: 0, content: {
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
								.frame(width: 21, height: 21)
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
					.frame(width: 311, height: 180)
					.padding()
					.background(.schemeForTips)
					.clipShape(RoundedRectangle(cornerRadius: Constants.Radius.regular))

					Triangle()
						.fill(.schemeForTips)
						.frame(width: 16, height: 16)
						.rotationEffect(Angle(degrees: 180))
						.frame(maxWidth: 250, alignment: .trailing)
				})
			}
		}
    }
}

#Preview {
	OverlayTip(tipIsActive: .constant(true))
}

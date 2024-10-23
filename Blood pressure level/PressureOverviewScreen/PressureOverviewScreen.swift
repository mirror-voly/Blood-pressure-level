//
//  PressureOverviewScreen.swift
//  Blood pressure level
//
//  Created by mix on 23.10.2024.
//

import SwiftUI


struct PressureOverviewScreen: View {
	
	@State var period: PresentationPeriod = .day
	
	var body: some View {
		ZStack {
			Color.teal
				.ignoresSafeArea()
			VStack {
				PresureOverviewHeaderView()
					.padding(.bottom)
				VStack(spacing: 16) {
					CustomSegmentContolView(period: $period)
					ZStack {
						Color.scheme
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
							
							Spacer()
						}
						.padding()
					}
					.clipShape(RoundedRectangle(cornerRadius: 24))
				}
				Spacer()
			}
			.padding()
		}
	}
}


#Preview {
    PressureOverviewScreen()
}

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

			if selectedMessurment.systolicLevelsMin != nil {
				BigOverlayView(selectedMessurment: selectedMessurment)
			} else {
				SmallOverlayView(selectedMessurment: selectedMessurment)
			}
		}
	}
}


//
//  Constants.swift
//  Blood pressure level
//
//  Created by mix on 25.10.2024.
//

import Foundation

enum Constants {

	enum Background {
		static let circleMainSize: CGFloat = 138
		static let circleMainBlurRadius: CGFloat = 50
		static let circleSecondSize: CGFloat = 78
		static let circleSecondBlurRadius: CGFloat = 25
		static let paddingTrailing: CGFloat = -50
		static let paddingTop: CGFloat = 50
	}
	
	enum TextField {
		static let fontSize: CGFloat = 18
		static let placeholderFontSize: CGFloat = 18
		static let overlayLineWidth: CGFloat = 1
	}
	
	enum Button {
		static let buttonWidth: CGFloat = 32
		static let buttonHeight: CGFloat = 32
		static let buttonCornerRadius: CGFloat = 14
	}
	
	enum Measurement {
		static let systolicPlaceholder: String = "120"
		static let diastolicPlaceholder: String = "90"
		static let pulsePlaceholder: String = "70"
	}
	
	enum Header {
		static let titleFontSize: CGFloat = 18
		static let subtitleFontSize: CGFloat = 14
	}
	
}

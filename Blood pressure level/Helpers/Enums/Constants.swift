//
//  Constants.swift
//  Blood pressure level
//
//  Created by mix on 25.10.2024.
//

import Foundation

enum Constants {
	
	enum General {
		static let originalColor: CGFloat = 1
	}
	
	enum Background {
		static let circleMainSize: CGFloat = 138
		static let circleMainBlurRadius: CGFloat = 50
		static let circleSecondSize: CGFloat = 78
		static let circleSecondBlurRadius: CGFloat = 30
		static let paddingTrailing: CGFloat = -50
		static let paddingTop: CGFloat = 50
		static let angle: CGFloat = 45
		static let circleMainColorOpacity = 0.8
		static let circleSecondColorOpacity = 0.7
	}
	
	enum FontSize {
		static let large: CGFloat = 24
		static let big: CGFloat = 18
		static let regular: CGFloat = 16
		static let small: CGFloat = 14
		static let micro: CGFloat = 12
	}
	
	enum Button {
		static let buttonHeight: CGFloat = 32
		static let buttonCornerRadius: CGFloat = 10
		static let buttonFontSize: CGFloat = 16
		static let buttonPadding: CGFloat = 10
	}
	
	
	enum Placeholder {
		static let systolicPlaceholder: String = "120"
		static let diastolicPlaceholder: String = "90"
		static let pulsePlaceholder: String = "70"
	}
	
	enum Spacing {
		static let largeSpacing: CGFloat = 24
		static let defaultSpacing: CGFloat = 16
		static let smallSpacing: CGFloat = 8
		
	}
	
	enum SegmentedControl {
		static let padding: CGFloat = 10
		static let buttonWidth: CGFloat = 99
		static let height: CGFloat = 26
		static let opacity: CGFloat = 0.3
		static let spacing: CGFloat = 6
	}
	
	enum Radius {
		static let big: CGFloat = 24
		static let regular: CGFloat = 16
		static let small: CGFloat = 14
	}
}

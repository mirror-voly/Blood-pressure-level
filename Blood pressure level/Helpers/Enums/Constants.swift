//
//  Constants.swift
//  Blood pressure level
//
//  Created by mix on 25.10.2024.
//

import Foundation

enum Constants {
	
	enum General {
		static let originalValue: CGFloat = 1
		static let emptyString: String = ""
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
		static let verySmall: CGFloat = 12
		static let micro: CGFloat = 10
	}
	
	enum Button {
		static let height: CGFloat = 32
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
		static let spacing: CGFloat = 6
	}
	
	enum Radius {
		static let big: CGFloat = 24
		static let regular: CGFloat = 16
		static let small: CGFloat = 14
	}
	
	enum Padding {
		static let big: CGFloat = 20
		static let regular: CGFloat = 16
		static let small: CGFloat = 8
		static let micro: CGFloat = 4
	}
	
	enum Opacity {
		static let big: CGFloat = 0.5
		static let regular: CGFloat = 0.3
	}
	
	enum FrameSize {
		static let chartLegendHeight: CGFloat = 8
		static let presureNoteViewHeaderHeight: CGFloat = 24
		static let tipButtonSize: CGFloat = 21
		static let tipBaseWidth: CGFloat = 311
		static let tipBaseHeight: CGFloat = 180
		static let tipTriangleSize: CGFloat = 16
		static let tipTriangleRotation: CGFloat = 180
		static let tipTriangleFrameWidth: CGFloat = 250
		
		static let mainFieldsViewHeight: CGFloat = 90
		static let pressureFieldsViewWidth: CGFloat = 214
	}
	
}

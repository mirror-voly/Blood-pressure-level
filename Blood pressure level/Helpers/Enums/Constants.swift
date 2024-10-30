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
		static let rotationAngle: CGFloat = 90
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
		static let big: CGFloat = 24
		static let regular: CGFloat = 16
		static let small: CGFloat = 8
		static let verySmall: CGFloat = 4
		static let non: CGFloat = 0
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
		static let verySmall: CGFloat = 8
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
		static let small: CGFloat = 0.2
	}
	
	enum Chart {
		static let maxHeight: CGFloat = 215
		static let chartLegendHeight: CGFloat = 8
		static let symbolSize: CGFloat = 40
		
		static let lineDash: CGFloat = 5
		static let curveLineWidth: CGFloat = 4
		
		static let topLine: Int = 200
		static let middleLine: Int = 100
		static let zeroLine: Int = 0
		
		static let highLine: Int = 150
		static let lowLine: Int = 50
		
		
		static let offset: CGFloat = 10
		static let scaleDomain: ClosedRange<Int> = 0...200
		static let chartYAxisMarks: [Int] = [0, 50, 100, 150, 200]
	}
	
	enum Time {
		static let hour: CGFloat = 3600
		static let halfanHour: CGFloat = 1800
		static let day: CGFloat = 86400
		static let halfADay: CGFloat = 43200
	}
	
	enum FrameSize {
		static let presureNoteViewHeaderHeight: CGFloat = 24
		static let tipButtonSize: CGFloat = 21
		static let tipBaseWidth: CGFloat = 311
		static let tipBaseHeight: CGFloat = 180
		static let tipTriangleSize: CGFloat = 16
		static let tipTriangleRotation: CGFloat = 180
		static let tipTriangleFrameWidth: CGFloat = 250
		static let presureNoteViewMaxHeight: CGFloat = 120
		
		static let mainFieldsViewHeight: CGFloat = 90
		static let pressureFieldsViewWidth: CGFloat = 214
		
		static let textItemWidth: CGFloat = 58
		static let overlaySelectionFrameMaxHeight: CGFloat = 142
		static let overlaySelectionNoteIconSize: CGFloat = 7
		static let summaryMaxHeight: CGFloat = 34
	}
	
}

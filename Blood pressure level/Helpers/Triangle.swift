//
//  Triangle.swift
//  Blood pressure level
//
//  Created by mix on 24.10.2024.
//

import SwiftUI

struct Triangle: Shape {
	func path(in rect: CGRect) -> Path {
		var path = Path()
		path.move(to: CGPoint(x: rect.midX, y: rect.minY)) // Верхняя точка
		path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY)) // Нижний правый угол
		path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY)) // Нижний левый угол
		path.closeSubpath() // Замыкаем путь
		return path
	}
}

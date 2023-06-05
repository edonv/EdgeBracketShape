//
//  EdgeBracketConfiguration.swift
//  
//
//  Created by Edon Valdman on 6/5/23.
//

import SwiftUI

public struct EdgeBracketConfiguration<S: ShapeStyle> {
    public static var `default`: EdgeBracketConfiguration<Color> {
        EdgeBracketConfiguration<Color>(
            edge: .leading,
            bracketLength: 10,
            shapeStyle: Color.accentColor,
            strokeStyle: .init(lineWidth: 1),
            clamped: true
        )
    }
    
    public var edge: Edge
    public var bracketLength: CGFloat
    public var shapeStyle: S
    public var strokeStyle: StrokeStyle
    public var clamped: Bool
    
    public init(edge: Edge = .leading,
                bracketLength: CGFloat = 10,
                padding: CGFloat? = 8,
                shapeStyle: S = Color.accentColor,
                strokeStyle: StrokeStyle = .init(),
                clamped: Bool = true) {
        self.edge = edge
        self.bracketLength = bracketLength
        self.shapeStyle = shapeStyle
        self.strokeStyle = strokeStyle
        self.clamped = clamped
    }
}

//
//  EdgeBracketConfiguration.swift
//  
//
//  Created by Edon Valdman on 6/5/23.
//

import SwiftUI

extension EdgeBracketShape {
    /// A container for the different drawing parameters of ``EdgeBracketShape/EdgeBracketShape``.
    public struct Configuration {
        /// The edge to draw the bracket.
        public var edge: Edge
        
        /// The length of the bracket "forks".
        public var bracketLength: CGFloat
        
        /// The [`ShapeStyle`](https://developer.apple.com/documentation/swiftui/shapestyle) to use for filling in the bracket.
        ///
        /// This can be something like a solid color, a gradient, or even a [`Material`](https://developer.apple.com/documentation/swiftui/material).
        public var shapeStyle: S
        
        /// The [`StrokeStyle`](https://developer.apple.com/documentation/swiftui/strokestyle) to use for drawing the stroke of the bracket.
        public var strokeStyle: StrokeStyle
        
        /// Whether the ``bracketLength`` should be "clamped" (limited) to the dimensions of the frame.
        ///
        /// If false, the bracket "forks" will be allowed to extend past the constraints of the frame.
        public var clamped: Bool
        
        public init(
            edge: Edge = .leading,
            bracketLength: CGFloat = 10,
            padding: CGFloat? = 8,
            shapeStyle: S = Color.accentColor,
            strokeStyle: StrokeStyle = .init(),
            clamped: Bool = true
        ) {
            self.edge = edge
            self.bracketLength = bracketLength
            self.shapeStyle = shapeStyle
            self.strokeStyle = strokeStyle
            self.clamped = clamped
        }
    }
}

extension EdgeBracketShape.Configuration where S == Color {
    /// An out-of-the-box standard configuration.
    public static let `default`: Self = Self(
        edge: .leading,
        bracketLength: 10,
        shapeStyle: Color.accentColor,
        strokeStyle: .init(lineWidth: 1),
        clamped: true
    )
}

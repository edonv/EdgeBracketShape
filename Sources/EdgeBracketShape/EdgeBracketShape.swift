//
//  EdgeBracketShape.swift
//  EdgeBracketShape
//
//  Created by Edon Valdman on 6/5/23.
//

import SwiftUI

/// A customizable bracket `Shape` to be used as on the edge of another `View`.
public struct EdgeBracketShape: Shape {
    /// The edge to draw the bracket.
    public let edge: Edge
    
    /// The length of the bracket "forks".
    public let bracketLength: CGFloat
    
    /// Whether the ``bracketLength`` should be "clamped" (limited) to the dimensions of the frame.
    ///
    /// If `false`, the bracket "forks" will be allowed to extend past the constraints of the frame.
    public let clamped: Bool
    
    public init(
        edge: Edge = .leading,
        bracketLength: CGFloat = 10,
        clamped: Bool = true
    ) {
        self.edge = edge
        self.bracketLength = bracketLength
        self.clamped = clamped
    }
    
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Properies are named relative to leading edge bracket
        let edgeStart: CGPoint
        let edgeEnd: CGPoint
        var topDashEnd: CGPoint
        var bottomDashEnd: CGPoint
        
        switch edge {
        case .leading, .trailing:
            edgeStart = CGPoint(x: rect.minX, y: rect.minY)
            edgeEnd = CGPoint(x: rect.minX, y: rect.maxY)
            topDashEnd = CGPoint(x: rect.minX + bracketLength, y: rect.minY)
            bottomDashEnd = CGPoint(x: rect.minX + bracketLength, y: rect.maxY)
            
            if clamped {
                topDashEnd.x = min(rect.minX + bracketLength, rect.maxX)
                bottomDashEnd.x = min(rect.minX + bracketLength, rect.maxX)
            }
            
        case .top, .bottom:
            edgeStart = CGPoint(x: rect.maxX, y: rect.minY)
            edgeEnd = CGPoint(x: rect.minX, y: rect.minY)
            topDashEnd = CGPoint(x: rect.maxX, y: rect.minY + bracketLength)
            bottomDashEnd = CGPoint(x: rect.minX, y: rect.minY + bracketLength)
            
            if clamped {
                topDashEnd.y = min(rect.minY + bracketLength, rect.maxY)
                bottomDashEnd.y = min(rect.minY + bracketLength, rect.maxY)
            }
        }
        
        // Dash 1
        path.move(to: topDashEnd)
        path.addLine(to: edgeStart)
        
        // Edge
        path.addLine(to: edgeEnd)
        
        // Dash 2
        path.addLine(to: bottomDashEnd)
        
        // For bottom and trailing shapes, rotate on center point 180°
        if [.bottom, .trailing].contains(edge) {
            return path.applying(
                .init(rotationAngle: .pi)
                .translatedBy(x: -rect.width, y: -rect.height)
            )
        } else {
            return path
        }
    }
}

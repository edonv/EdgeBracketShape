//
//  EdgeBracketShape.swift
//  EdgeBracketShape
//
//  Created by Edon Valdman on 6/5/23.
//

import SwiftUI

/// A customizable bracket `Shape` to be used as on the edge of another `View`.
public struct EdgeBracketShape<S: ShapeStyle>: Shape {
    let configuration: EdgeBracketConfiguration<S>
    
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Properies are named relative to leading edge bracket
        let edgeStart: CGPoint
        let edgeEnd: CGPoint
        var topDashEnd: CGPoint
        var bottomDashEnd: CGPoint
        
        switch configuration.edge {
        case .leading:
            edgeStart = CGPoint(x: rect.minX, y: rect.minY)
            edgeEnd = CGPoint(x: rect.minX, y: rect.maxY)
            topDashEnd = CGPoint(x: rect.minX + configuration.bracketLength, y: rect.minY)
            bottomDashEnd = CGPoint(x: rect.minX + configuration.bracketLength, y: rect.maxY)
            
            if configuration.clamped {
                topDashEnd.x = min(rect.minX + configuration.bracketLength, rect.maxX)
                bottomDashEnd.x = min(rect.minX + configuration.bracketLength, rect.maxX)
            }
            
        case .top:
            edgeStart = CGPoint(x: rect.maxX, y: rect.minY)
            edgeEnd = CGPoint(x: rect.minX, y: rect.minY)
            topDashEnd = CGPoint(x: rect.maxX, y: rect.minY + configuration.bracketLength)
            bottomDashEnd = CGPoint(x: rect.minX, y: rect.minY + configuration.bracketLength)
            
            if configuration.clamped {
                topDashEnd.y = min(rect.minY + configuration.bracketLength, rect.maxY)
                bottomDashEnd.y = min(rect.minY + configuration.bracketLength, rect.maxY)
            }
            
        case .trailing:
            edgeStart = CGPoint(x: rect.maxX, y: rect.maxY)
            edgeEnd = CGPoint(x: rect.maxX, y: rect.minY)
            topDashEnd = CGPoint(x: rect.maxX - configuration.bracketLength, y: rect.maxY)
            bottomDashEnd = CGPoint(x: rect.maxX - configuration.bracketLength, y: rect.minY)
            
            if configuration.clamped {
                topDashEnd.x = max(rect.maxX - configuration.bracketLength, rect.minX)
                bottomDashEnd.x = max(rect.maxX - configuration.bracketLength, rect.minX)
            }
            
        case .bottom:
            edgeStart = CGPoint(x: rect.minX, y: rect.maxY)
            edgeEnd = CGPoint(x: rect.maxX, y: rect.maxY)
            topDashEnd = CGPoint(x: rect.minX, y: rect.maxY - configuration.bracketLength)
            bottomDashEnd = CGPoint(x: rect.maxX, y: rect.maxY - configuration.bracketLength)
            
            if configuration.clamped {
                topDashEnd.y = max(rect.maxY - configuration.bracketLength, rect.minY)
                bottomDashEnd.y = max(rect.maxY - configuration.bracketLength, rect.minY)
            }
        }
        
        // Dash 1
        path.move(to: topDashEnd)
        path.addLine(to: edgeStart)
        
        // Edge
        path.addLine(to: edgeEnd)
        
        // Dash 2
        path.addLine(to: bottomDashEnd)
        
        return path
    }
}

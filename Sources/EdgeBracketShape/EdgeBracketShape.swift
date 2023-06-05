//
//  EdgeBracketShape.swift
//  EdgeBracketShape
//
//  Created by Edon Valdman on 6/5/23.
//

import SwiftUI

public struct EdgeBracketShape: Shape {
    var edge: Edge
    var bracketLength: CGFloat
    var clamped = false
    
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Properies are named relative to leading edge bracket
        let edgeStart: CGPoint
        let edgeEnd: CGPoint
        var topDashEnd: CGPoint
        var bottomDashEnd: CGPoint
        
        switch edge {
        case .leading:
            edgeStart = CGPoint(x: rect.minX, y: rect.minY)
            edgeEnd = CGPoint(x: rect.minX, y: rect.maxY)
            topDashEnd = CGPoint(x: rect.minX + bracketLength, y: rect.minY)
            bottomDashEnd = CGPoint(x: rect.minX + bracketLength, y: rect.maxY)
            
            if clamped {
                topDashEnd.x = min(rect.minX + bracketLength, rect.maxX)
                bottomDashEnd.x = min(rect.minX + bracketLength, rect.maxX)
            }
            
        case .top:
            edgeStart = CGPoint(x: rect.maxX, y: rect.minY)
            edgeEnd = CGPoint(x: rect.minX, y: rect.minY)
            topDashEnd = CGPoint(x: rect.maxX, y: rect.minY + bracketLength)
            bottomDashEnd = CGPoint(x: rect.minX, y: rect.minY + bracketLength)
            
            if clamped {
                topDashEnd.y = min(rect.minY + bracketLength, rect.maxY)
                bottomDashEnd.y = min(rect.minY + bracketLength, rect.maxY)
            }
            
        case .trailing:
            edgeStart = CGPoint(x: rect.maxX, y: rect.maxY)
            edgeEnd = CGPoint(x: rect.maxX, y: rect.minY)
            topDashEnd = CGPoint(x: rect.maxX - bracketLength, y: rect.maxY)
            bottomDashEnd = CGPoint(x: rect.maxX - bracketLength, y: rect.minY)
            
            if clamped {
                topDashEnd.x = max(rect.maxX - bracketLength, rect.minX)
                bottomDashEnd.x = max(rect.maxX - bracketLength, rect.minX)
            }
            
        case .bottom:
            edgeStart = CGPoint(x: rect.minX, y: rect.maxY)
            edgeEnd = CGPoint(x: rect.maxX, y: rect.maxY)
            topDashEnd = CGPoint(x: rect.minX, y: rect.maxY - bracketLength)
            bottomDashEnd = CGPoint(x: rect.maxX, y: rect.maxY - bracketLength)
            
            if clamped {
                topDashEnd.y = max(rect.maxY - bracketLength, rect.minY)
                bottomDashEnd.y = max(rect.maxY - bracketLength, rect.minY)
            }
        }
        
        // Edge
        path.move(to: edgeStart) // topLeft
        path.addLine(to: edgeEnd) // bottomLeft
        
        // Dash 1
        path.move(to: edgeStart)
        path.addLine(to: topDashEnd) // topRight
        
        // Dash 2
        path.move(to: edgeEnd)
        path.addLine(to: bottomDashEnd) // bottomRight
        
        return path
    }
}

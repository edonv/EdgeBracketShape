//
//  UnitPoint+Extensions.swift
//
//
//  Created by Edon Valdman on 3/21/24.
//

import SwiftUI

extension UnitPoint {
    var cgPoint: CGPoint { .init(x: self.x, y: self.y) }
    
    func applied(to rect: CGRect) -> CGPoint {
        .init(
            x: (rect.maxX * self.x) - rect.minX,
            y: (rect.maxY * self.y) - rect.minY
        )
    }
    
    func applying(_ t: CGAffineTransform) -> UnitPoint {
        let transformed = cgPoint.applying(t)
        return .init(x: transformed.x, y: transformed.y)
    }
    
    func angle(to otherPoint: UnitPoint) -> Angle {
        let v1 = CGVector(dx: self.x - 0.5, dy: self.y - 0.5)
        let v2 = CGVector(dx: otherPoint.x - 0.5, dy: otherPoint.y - 0.5)
        let radians = atan2(v2.dy, v2.dx) - atan2(v1.dy, v1.dx)
        
        return .degrees(radians * 180 / .pi)
    }
}

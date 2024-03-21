//
//  CGPoint+Extensions.swift
//
//
//  Created by Edon Valdman on 3/21/24.
//

import SwiftUI

extension CGPoint {
    var unitPoint: UnitPoint { .init(x: self.x, y: self.y) }
    
    func newPoint(
        withLength distance: CGFloat,
        atAngle angle: Angle
    ) -> CGPoint {
        var endPoint = CGPoint()
        endPoint.x = distance * cos(angle.radians) + self.x
        endPoint.y = distance * sin(angle.radians) + self.y
        return endPoint
    }
}

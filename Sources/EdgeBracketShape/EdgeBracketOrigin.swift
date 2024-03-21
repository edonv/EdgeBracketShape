//
//  EdgeBracketOrigin.swift
//  
//
//  Created by Edon Valdman on 3/21/24.
//

import SwiftUI

extension EdgeBracket {
    /// A type that converts a given [`Edge`](https://developer.apple.com/documentation/swiftui/edge) to an animatable set of points to draw the shape from from.
    public struct Origin: Sendable {
        internal var edgeCenter: UnitPoint
        
        internal init(edge: Edge) {
            switch edge {
            case .top:
                self.edgeCenter = .top
            case .leading:
                self.edgeCenter = .leading
            case .bottom:
                self.edgeCenter = .bottom
            case .trailing:
                self.edgeCenter = .trailing
            }
        }
        
        internal func pathPoints(
            for rect: CGRect,
            withBracketLength bracketLength: CGFloat
        ) -> [CGPoint] {
            // everything is relative to .top, until transformed
            
            // start with top corners
            let unitPoints: [UnitPoint] = [
                .topLeading, .topTrailing,
            ]
            
            // rotate to correct side, then scale to rect
            let unitRotation = rotationTransform(
                for: .init(x: 0, y: 0, width: 1, height: 1)
            )
            var convertedPoints = unitPoints
                .map { pt in
                    pt.applying(unitRotation)
                }
                .map { pt in
                    pt.applied(to: rect)
                }
            
            // create bracket points at 90° angles
            let bracketEnd1 = convertedPoints[0]
                .newPoint(
                    withLength: bracketLength,
                    atAngle: rotateAngle + .degrees(90)
                )
            let bracketEnd2 = convertedPoints[1]
                .newPoint(
                    withLength: bracketLength,
                    atAngle: rotateAngle + .degrees(90)
                )
            
            // insert bracket points at start and end of array
            convertedPoints.insert(
                bracketEnd1,
                at: 0
            )
            convertedPoints.insert(
                bracketEnd2,
                at: convertedPoints.endIndex
            )
            
            // return full array
            return convertedPoints
        }
        
        private var rotateAngle: Angle {
            UnitPoint.top.angle(to: edgeCenter)
        }
        
        private func rotationTransform(for rect: CGRect) -> CGAffineTransform {
            .init(translationX: -rect.midX, y: -rect.midY)
            .concatenating(.init(rotationAngle: rotateAngle.radians))
            .concatenating(.init(translationX: rect.midX, y: rect.midY))
        }
    }
}

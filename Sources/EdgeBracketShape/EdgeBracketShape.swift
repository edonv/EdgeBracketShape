//
//  EdgeBracketShape.swift
//  EdgeBracketShape
//
//  Created by Edon Valdman on 6/5/23.
//

import SwiftUI

/// A customizable bracket `Shape` to be used around the side of another `View`.
public struct EdgeBracket: Shape {
    /// Animatable origin of the shape.
    ///
    /// This keeps track of which edge to draw the bracket, while calculating animatable points for the shape.
    public var origin: Origin
    
    /// The length of the bracket "forks".
    public var forkLength: CGFloat
    
    /// Whether the ``forkLength`` should be "clamped" (limited) to the dimensions of the frame.
    ///
    /// If `false`, the bracket "forks" will be allowed to extend past the constraints of the frame.
    public let clamped: Bool
    
    /// Creates an `EdgeBracket` shape.
    /// - Parameters:
    ///   - edge: The edge of the frame that the shape should be drawn on.
    ///   - forkLength: The length of the bracket "forks".
    ///   - clamped: Whether the `forkLength` should be "clamped" (limited) to the dimensions of the frame.
    public init(
        edge: Edge = .leading,
        forkLength: CGFloat = 10,
        clamped: Bool = true
    ) {
        self.origin = .init(edge: edge)
        self.forkLength = forkLength
        self.clamped = clamped
    }
    
    public var animatableData: AnimatablePair<UnitPoint.AnimatableData, CGFloat> {
        get {
            .init(origin.edgeCenter.animatableData, forkLength)
        } set {
            self.origin.edgeCenter.animatableData = newValue.first
            self.forkLength = newValue.second
        }
    }
    
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        let points = origin.pathPoints(for: rect, withForkLength: forkLength)
        path.addLines(points)
        return path
    }
    
    /// Its behaviour is to *not* flip automatically in right-to-left contexts so it acts consistently.
    ///
    /// When using ``SwiftUI/View/edgeBracket(_:lineWidth:edge:forkLength:clamped:withPadding:)`` or ``SwiftUI/View/edgeBracket(_:style:edge:forkLength:clamped:withPadding:)`` it will automatically mirror. When using ``EdgeBracketShape`` directly, you can use [`flipsForRightToLeftLayoutDirection(_:)`](https://developer.apple.com/documentation/familycontrols/familyactivitypicker/flipsforrighttoleftlayoutdirection(_:)) to control this manually.
    @available(iOS 17, macCatalyst 17, macOS 14, tvOS 17, watchOS 10, *)
    public var layoutDirectionBehavior: LayoutDirectionBehavior { .fixed }
}

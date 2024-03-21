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
    public var bracketLength: CGFloat
    
    /// Whether the ``bracketLength`` should be "clamped" (limited) to the dimensions of the frame.
    ///
    /// If `false`, the bracket "forks" will be allowed to extend past the constraints of the frame.
    public let clamped: Bool
    
    public init(
        edge: Edge = .leading,
        bracketLength: CGFloat = 10,
        clamped: Bool = true
    ) {
        self.origin = .init(edge: edge)
        self.bracketLength = bracketLength
        self.clamped = clamped
    }
    
    public var animatableData: AnimatablePair<UnitPoint.AnimatableData, CGFloat> {
        get {
            return .init(origin.edgeCenter.animatableData, bracketLength)
        } set {
            self.origin.edgeCenter.animatableData = newValue.first
            self.bracketLength = newValue.second
        }
    }
    
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        let points = origin.pathPoints(for: rect, withBracketLength: bracketLength)
        path.addLines(points)
        return path
    }
    
    /// Its behaviour is to not flip automatically in right-to-left contexts so it acts consistently.
    ///
    /// When using ``SwiftUI/View/edgeBracket(_:lineWidth:edge:bracketLength:clamped:withPadding:)`` or ``SwiftUI/View/edgeBracket(_:style:edge:bracketLength:clamped:withPadding:)`` it will automatically mirror. When using ``EdgeBracketShape`` directly, you can use [`flipsForRightToLeftLayoutDirection(_:)`](https://developer.apple.com/documentation/familycontrols/familyactivitypicker/flipsforrighttoleftlayoutdirection(_:)) to control this manually.
    @available(iOS 17, macCatalyst 17, macOS 14, tvOS 17, watchOS 10, *)
    public var layoutDirectionBehavior: LayoutDirectionBehavior { .fixed }
}

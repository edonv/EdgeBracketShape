//
//  EdgeBracketViewModifier.swift
//  
//
//  Created by Edon Valdman on 6/5/23.
//

import SwiftUI

private struct EdgeBracketViewModifier<S: ShapeStyle>: ViewModifier {
    let shapeStyle: S
    
    let strokeStyle: StrokeStyle
    
    let edge: Edge
    
    let bracketLength: CGFloat
    
    let clamped: Bool
    
    /// The amount of padding between the inner view and the bracket shape.
    let padding: CGFloat?
    
    func body(content: Content) -> some View {
        content
            .padding(.all, padding)
            .overlay(
                EdgeBracketShape(
                    edge: edge,
                    bracketLength: bracketLength,
                    clamped: clamped
                )
                .stroke(shapeStyle, style: strokeStyle)
                .flipsForRightToLeftLayoutDirection(true)
            )
    }
}

extension View {
    /// Draws a ``EdgeBracketShape/EdgeBracketShape`` on a specific edge of the view.
    /// - Parameters:
    ///   - content: The color or gradient with which to stroke this shape.
    ///   - style: The `StrokeStyle` to use for drawing the shape.
    ///   - edge: The edge to draw the bracket.
    ///   - bracketLength: The length of the bracket "forks".
    ///   - clamped: Whether the `bracketLength` should be "clamped" (limited) to the dimensions of the frame.
    ///   - padding: The amount of padding between the inner view and the bracket shape.
    /// - Returns: A view with an ``EdgeBracketShape/EdgeBracketShape`` wrapped around the specified edge.
    @_disfavoredOverload
    public func edgeBracket<S: ShapeStyle>(
        _ content: S = Color.accentColor,
        style: StrokeStyle = .init(),
        edge: Edge = .leading,
        bracketLength: CGFloat = 10,
        clamped: Bool = true,
        withPadding padding: CGFloat = 8
    ) -> some View {
        modifier(
            EdgeBracketViewModifier(
                shapeStyle: content,
                strokeStyle: style,
                edge: edge,
                bracketLength: bracketLength,
                clamped: clamped,
                padding: padding
            )
        )
    }
    
    /// Draws a ``EdgeBracketShape/EdgeBracketShape`` on a specific edge of the view.
    /// - Parameters:
    ///   - content: The color or gradient with which to stroke this shape.
    ///   - lineWidth: The width of the stroke that outlines this shape.
    ///   - edge: The edge to draw the bracket.
    ///   - bracketLength: The length of the bracket "forks".
    ///   - clamped: Whether the `bracketLength` should be "clamped" (limited) to the dimensions of the frame.
    ///   - padding: The amount of padding between the inner view and the bracket shape.
    /// - Returns: A view with an ``EdgeBracketShape/EdgeBracketShape`` wrapped around the specified edge.
    public func edgeBracket<S: ShapeStyle>(
        _ content: S = Color.accentColor,
        lineWidth: CGFloat = 1,
        edge: Edge = .leading,
        bracketLength: CGFloat = 10,
        clamped: Bool = true,
        withPadding padding: CGFloat = 8
    ) -> some View {
        modifier(
            EdgeBracketViewModifier(
                shapeStyle: content,
                strokeStyle: .init(lineWidth: lineWidth),
                edge: edge,
                bracketLength: bracketLength,
                clamped: clamped,
                padding: padding
            )
        )
    }
}

struct EdgeBracketViewModifier_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("Test")
                .edgeBracket(
                    LinearGradient(colors: [.blue, .green], startPoint: .leading, endPoint: .trailing),
                    style: .init(lineWidth: 4, lineCap: .round, lineJoin: .round),
                    edge: .bottom
                )
            
            Text("טסט")
                .edgeBracket()
                .environment(\.layoutDirection, .rightToLeft)
        }
    }
}

//
//  EdgeBracketViewModifier.swift
//  
//
//  Created by Edon Valdman on 6/5/23.
//

import SwiftUI

public struct EdgeBracketViewModifier<S: ShapeStyle>: ViewModifier {
    /// The configuration of the ``EdgeBracketShape/EdgeBracketShape`` to be drawn.
    public var configuration: EdgeBracketConfiguration<S>
    
    /// The amount of padding between the inner view and the bracket shape.
    public var padding: CGFloat?
    
    public func body(content: Content) -> some View {
        content
            .padding(.all, padding)
            .overlay(
                EdgeBracketShape(configuration: configuration)
                    .stroke(configuration.shapeStyle, style: configuration.strokeStyle)
                    .flipsForRightToLeftLayoutDirection(true)
            )
    }
}

extension View {
    /// Draws a ``EdgeBracketShape/EdgeBracketShape`` on a specific edge of the view.
    /// - Parameters:
    ///   - configuration: The configuration of the ``EdgeBracketShape/EdgeBracketShape`` to be drawn.
    ///   - padding: The amount of padding between the inner view and the bracket shape.
    /// - Returns: A view with an ``EdgeBracketShape/EdgeBracketShape`` wrapped around the specified edge.
    public func edgeBracket<S: ShapeStyle>(configuration: EdgeBracketConfiguration<S> = .default, withPadding padding: CGFloat = 8) -> some View {
        modifier(EdgeBracketViewModifier(configuration: configuration, padding: padding))
    }
}

private struct EdgeBracketViewModifier_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("Test")
                .edgeBracket(configuration: .init(
                    edge: .top,
                    shapeStyle: LinearGradient(colors: [.blue, .green], startPoint: .leading, endPoint: .trailing),
                    strokeStyle: .init(lineWidth: 4, lineCap: .round, lineJoin: .round)
                ))
            
            Text("טסט")
                .edgeBracket()
                .environment(\.layoutDirection, .rightToLeft)
        }
    }
}

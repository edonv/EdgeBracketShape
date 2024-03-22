//
//  EdgeBracketViewModifier.swift
//  
//
//  Created by Edon Valdman on 6/5/23.
//

import SwiftUI

private struct EdgeBracketViewModifier<S: ShapeStyle>: ViewModifier {
    @Environment(\.layoutDirection)
    private var layoutDirection
    
    let shapeStyle: S
    
    let strokeStyle: StrokeStyle
    
    let edge: Edge
    
    let forkLength: CGFloat
    
    let clamped: Bool
    
    /// The amount of padding between the inner view and the bracket shape.
    let padding: CGFloat?
    
    func body(content: Content) -> some View {
        content
            .padding(.all, padding)
            .overlayBackport {
                EdgeBracket(
                    edge: edge,
                    forkLength: forkLength,
                    clamped: clamped
                )
                // Using this instead of .flipsForRightToLeftLayoutDirection means it doesn't flip the ShapeStyle (could be a gradient)
                .scale(
                    x: layoutDirection == .leftToRight ? 1 : -1,
                    anchor: .center
                )
                .stroke(shapeStyle, style: strokeStyle)
            }
    }
}

extension View {
    /// Draws an ``EdgeBracketShape/EdgeBracket`` on a specific edge of the view.
    ///
    /// This modifier lets you set the [`StrokeStyle`](https://developer.apple.com/documentation/swiftui/strokestyle) of the shape. If you only need to set stroke width, use ``edgeBracket(_:lineWidth:edge:forkLength:clamped:withPadding:)`` instead.
    ///
    /// > Note: When in a right-to-left context, the shape will automatically be mirrored horizontally.
    /// - Parameters:
    ///   - content: The color or gradient with which to stroke this shape.
    ///   - style: The `StrokeStyle` to use for drawing the shape.
    ///   - edge: The edge of the parent view along which to draw the bracket.
    ///   - forkLength: The length of the bracket "forks".
    ///   - clamped: Whether the brackets' length (`forkLength`) should be "clamped" (limited) to the dimensions of the frame.
    ///   - padding: The amount of padding between the inner view and the bracket shape.
    /// - Returns: A view with an ``EdgeBracketShape/EdgeBracket`` wrapped around the specified edge.
    @_disfavoredOverload
    public func edgeBracket<S: ShapeStyle>(
        _ content: S = Color.accentColor,
        style: StrokeStyle = .init(),
        edge: Edge = .leading,
        forkLength: CGFloat = 10,
        clamped: Bool = true,
        withPadding padding: CGFloat = 8
    ) -> some View {
        modifier(
            EdgeBracketViewModifier(
                shapeStyle: content,
                strokeStyle: style,
                edge: edge,
                forkLength: forkLength,
                clamped: clamped,
                padding: padding
            )
        )
    }
    
    /// Draws an ``EdgeBracketShape/EdgeBracket`` on a specific edge of the view.
    ///
    /// This modifier only lets you set the stroke width of the shape. If you need to set the full [`StrokeStyle`](https://developer.apple.com/documentation/swiftui/strokestyle), use ``edgeBracket(_:style:edge:forkLength:clamped:withPadding:)`` instead.
    ///
    /// > Note: When in a right-to-left context, the shape will automatically be mirrored horizontally.
    /// - Parameters:
    ///   - content: The color or gradient with which to stroke this shape.
    ///   - lineWidth: The width of the stroke that outlines this shape.
    ///   - edge: The edge of the parent view along which to draw the bracket.
    ///   - forkLength: The length of the bracket "forks".
    ///   - clamped: Whether the brackets' length (`forkLength`) should be "clamped" (limited) to the dimensions of the frame.
    ///   - padding: The amount of padding between the inner view and the bracket shape.
    /// - Returns: A view with an ``EdgeBracketShape/EdgeBracket`` wrapped around the specified edge.
    public func edgeBracket<S: ShapeStyle>(
        _ content: S = Color.accentColor,
        lineWidth: CGFloat = 1,
        edge: Edge = .leading,
        forkLength: CGFloat = 10,
        clamped: Bool = true,
        withPadding padding: CGFloat = 8
    ) -> some View {
        modifier(
            EdgeBracketViewModifier(
                shapeStyle: content,
                strokeStyle: .init(lineWidth: lineWidth),
                edge: edge,
                forkLength: forkLength,
                clamped: clamped,
                padding: padding
            )
        )
    }
}

struct EdgeBracketViewModifier_Previews: View {
    @State private var bracketToggle = false
    
    @State private var d = 0
    private let colors: [Color] = [.blue, .green, .yellow, .red]
    
    var body: some View {
        VStack {
            Text("Test")
                .edgeBracket(
                    LinearGradient(colors: [.blue, .green], startPoint: .leading, endPoint: .trailing),
                    style: .init(lineWidth: 4, lineCap: .round, lineJoin: .round),
                    edge: .bottom,
                    forkLength: bracketToggle ? 10 : 30
                )
                .environment(\.layoutDirection, .rightToLeft)
            
            Button("טסט") {
                withAnimation {
                    d += 1
                }
            }
            .edgeBracket(edge: .leading)
            .environment(\.layoutDirection, .rightToLeft)
            
            HStack {
                ForEach(0..<Edge.allCases.count, id: \.self) { i in
                    let adj = (i + d) % Edge.allCases.count
                    Text("Test")
                        .foregroundColor(colors[adj])
                        .edgeBracket(
                            colors[adj],
                            style: .init(lineWidth: 3, lineCap: .round, lineJoin: .round),
                            edge: Edge.allCases[adj],
                            forkLength: adj == 0 ? 10 : 30
                        )
                }
            }
        }
    }
}

#Preview {
    EdgeBracketViewModifier_Previews()
}

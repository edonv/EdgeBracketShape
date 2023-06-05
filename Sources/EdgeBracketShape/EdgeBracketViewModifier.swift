//
//  EdgeBracketViewModifier.swift
//  
//
//  Created by Edon Valdman on 6/5/23.
//

import SwiftUI

public struct EdgeBracketViewModifier<S: ShapeStyle>: ViewModifier {
    public var configuration: EdgeBracketConfiguration<S>
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
    public func edgeBracket<S: ShapeStyle>(configuration: EdgeBracketConfiguration<S> = .default, withPadding padding: CGFloat = 8) -> some View {
        modifier(EdgeBracketViewModifier(configuration: configuration, padding: padding))
    }
}

struct EdgeBracketViewModifier_Previews: PreviewProvider {
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

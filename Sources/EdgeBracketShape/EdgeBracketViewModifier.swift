//
//  EdgeBracketViewModifier.swift
//  
//
//  Created by Edon Valdman on 6/5/23.
//

import SwiftUI

public struct EdgeBracketViewModifier<S: ShapeStyle>: ViewModifier {
    var configuration: EdgeBracketConfiguration<S>
    
    public func body(content: Content) -> some View {
        content
            .padding(.all, configuration.padding)
            .overlay(
                EdgeBracketShape(configuration: configuration)
                    .stroke(configuration.shapeStyle, style: configuration.strokeStyle)
                    .flipsForRightToLeftLayoutDirection(true)
            )
    }
}

extension View {
    public func edgeBracket<S: ShapeStyle>(configuration: EdgeBracketConfiguration<S>) -> some View {
        modifier(EdgeBracketViewModifier(configuration: configuration))
    }
}

struct EdgeBracketViewModifier_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("Test")
                .edgeBracket(configuration: .init(
                    edge: .top,
                    shapeStyle: LinearGradient(colors: [.blue, .green], startPoint: .leading, endPoint: .trailing),
                    strokeStyle: .init(lineWidth: 2)
                ))
            
            Text("טסט")
                .edgeBracket(configuration: .default)
                .environment(\.layoutDirection, .rightToLeft)
        }
    }
}

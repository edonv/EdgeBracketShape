//
//  EdgeBracketViewModifier.swift
//  
//
//  Created by Edon Valdman on 6/5/23.
//

import SwiftUI

public struct EdgeBracketViewModifier: ViewModifier {
    var edge: Edge
    var bracketLength: CGFloat
    var padding: CGFloat?
    var clamped: Bool
    
    public func body(content: Content) -> some View {
        content
            .padding(.all, padding)
            .overlay(
                EdgeBracketShape(edge: edge, bracketLength: bracketLength, clamped: clamped)
                    .stroke(Color.accentColor, lineWidth: 1)
                .flipsForRightToLeftLayoutDirection(true)
            )
    }
}

extension View {
    public func edgeBracket(edge: Edge = .leading, bracketLength: CGFloat = 10, padding: CGFloat? = nil, clamped: Bool = false) -> some View {
        modifier(EdgeBracketViewModifier(edge: edge, bracketLength: bracketLength, padding: padding, clamped: clamped))
    }
}

struct EdgeBracketViewModifier_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("Test")
                .edgeBracket(edge: .leading, bracketLength: 10, padding: 8, clamped: true)
            
            Text("טסט")
                .edgeBracket(edge: .leading, bracketLength: 10, padding: 8, clamped: true)
                .environment(\.layoutDirection, .rightToLeft)
        }
    }
}

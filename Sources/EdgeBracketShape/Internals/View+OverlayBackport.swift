//
//  View+OverlayBackport.swift
//
//
//  Created by Edon Valdman on 3/22/24.
//

import SwiftUI

extension View {
    @ViewBuilder
    func overlayBackport<Content: View>(
        alignment: Alignment = .center,
        @ViewBuilder _ content: () -> Content
    ) -> some View {
        if #available(iOS 15, macCatalyst 15, macOS 12, tvOS 15, watchOS 8, *) {
            self.overlay(alignment: alignment, content: content)
        } else {
            self.overlay(content(), alignment: alignment)
        }
    }
}

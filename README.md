# EdgeBracketShape

A `SwiftUI` `Shape` that cleanly wraps around any edge of a `View`. It's drawing settings are customizable via `EdgeBracketConfiguration`, allowing for changing the padding, which edge to draw on, [StrokeStyle](https://developer.apple.com/documentation/swiftui/strokestyle), coloring (via  [ShapeStyle](https://developer.apple.com/documentation/swiftui/shapestyle), allowing for solid colors or gradients), the length of the brackets, and whether the set length of the brackets should stay clamped to the size of the frame. Additionally, it will flip horizontally automatically in support of right-to-left languages.

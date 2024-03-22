# ``SwiftUI/View/edgeBracket(_:lineWidth:edge:forkLength:clamped:withPadding:)``

## Example

Although `EdgeBracket` can be used as a standalone shape, it's best used via the accompanying `ViewModifier`:

```swift
struct BracketTest: View {
    let strokeStyle = StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round)

    var label: String
    var color: Color
    var edge: Edge

    var body: some View {
        Text(label)
            .foregroundColor(.blue)
            .edgeBracket(color, style: strokeStyle, edge: edge)
    }
}
```

A few together might look like this:

```swift
struct EdgeBracketExample: View {
    var body: some View {
        HStack(spacing: 18) {
            BracketTest(label: "Test A", color: .blue, edge: .top)
            BracketTest(label: "Test B", color: .green, edge: .leading)
            BracketTest(label: "Test C", color: .yellow, edge: .bottom)
            BracketTest(label: "Test D", color: .red, edge: .trailing)
        }
    }
}
```

![4 examples of the `EdgeBracket` shape.](example)

> Note: This example uses the alternate version of this modifier, which uses `StrokeStyle` instead of a line width. See below for that version.

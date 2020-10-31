![Language: Swift](https://img.shields.io/badge/language-swift-orange.svg)
![platforms](https://img.shields.io/badge/platforms-iPhone%20%7C%20iPad%20%7C%20macOS-lightgrey)

## AppIconGenerator

A library for creating App Icons from `SwiftUI` views.

### Installation

AppIconGenerator is available as a Swift Package.

``` Swift
import AppIconGenerator
```

### Examples

Assuming we have a `SwiftUI` View:
``` Swift
struct IconView: View { ... }
```
we can save it directly to a file:
``` Swift
AppIconGenerator().generateIcons(from: IconView())
```
By default it creates icons for all App Icon sizes:
``` Swift
static let appIconSizes = [20, 29, 40, 58, 60, 76, 80, 87, 120, 152, 167, 180, 1024]
```
However, you're free to modify the parameters as you wish:
``` Swift
AppIconGenerator().generateIcons(from: IconView(), filename = "Icon", sizes = [100, 200, 300])
```
Full demo:
``` Swift
import AppIconGenerator
import SwiftUI

struct ContentView: View {
    var body: some View {
        IconView()
            .frame(width: 100, height: 100)
            .onAppear {
                AppIconGenerator().generateIcons(from: IconView())
            }
    }
}

struct IconView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.blue
                Circle()
                    .fill(Color.red)
                    .frame(width: geometry.size.width / 2, height: geometry.size.height / 2)
            }
        }
    }
}
```

### Output

Generated icons will be saved in the documents directory (the full path will be printed to the console):

> File saved to: /Users/.../Library/Developer/CoreSimulator/Devices/.../Documents/Icon1024.png

### License

AppIconGenerator is available under the MIT license. See the LICENSE file for more info.

<p align="center">
  <a href="https://github.com/pawello2222/AppIconGenerator"><img src="https://img.shields.io/github/workflow/status/pawello2222/AppIconGenerator/build?logo=github" alt="Build"></a>
  <a href="https://github.com/pawello2222/AppIconGenerator"><img src="https://img.shields.io/badge/language-swift-orange.svg" alt="Language"></a>
  <a href="https://github.com/pawello2222/AppIconGenerator"><img src="https://img.shields.io/badge/platform-iOS-lightgrey" alt="Supported Platform"></a>
  <a href="https://github.com/pawello2222/AppIconGenerator"><img src="https://img.shields.io/badge/SPM-compatible-brightgreen.svg" alt="Swift Package Manager"></a>
  <a href="https://github.com/pawello2222/AppIconGenerator/releases"><img src="https://img.shields.io/github/v/release/pawello2222/AppIconGenerator" alt="Release version"></a>
  <a href="https://github.com/pawello2222/AppIconGenerator/blob/main/LICENSE"><img src="https://img.shields.io/github/license/pawello2222/AppIconGenerator" alt="License"></a>
</p>
<br>

# AppIconGenerator

A library for creating App Icons from SwiftUI views.

## Installation

AppIconGenerator is available as a Swift Package.

## Examples

Assuming we have a SwiftUI view:
``` Swift
struct IconView: View { ... }
```
we can save it directly to a file:
``` Swift
IconView()
    .generateIcons()
```
By default it creates icons for all App Icon sizes:
``` Swift
static let appIconSizes = [20, 29, 40, 58, 60, 76, 80, 87, 120, 152, 167, 180, 1024]
```
However, you're free to modify the parameters as you wish:
``` Swift
AppIconGenerator.shared.generateIcons(from: IconView(), filename = "Icon", sizes = [100, 200, 300])
```
Full demo:
``` Swift
import AppIconGenerator
import SwiftUI

struct ContentView: View {
    var body: some View {
        IconView()
            .frame(width: 100, height: 100)
            .generateIcons()
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

## License

AppIconGenerator is available under the MIT license. See the [LICENSE](https://github.com/pawello2222/AppIconGenerator/blob/main/LICENSE) file for more info.

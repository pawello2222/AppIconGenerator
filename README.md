<p align="center">
  <img src="./.resources/Assets/logo.png" alt="App Icon Generator logo" height=150>
</p>
<p align="center">
  <a href="https://github.com/pawello2222/AppIconGenerator/actions?query=branch%3Amain">
    <img src="https://img.shields.io/github/actions/workflow/status/pawello2222/AppIconGenerator/ci.yml?logo=github" alt="Build">
  </a>
  <a href="https://github.com/pawello2222/AppIconGenerator">
    <img src="https://img.shields.io/badge/language-swift-orange.svg" alt="Language">
  </a>
  <a href="https://github.com/pawello2222/AppIconGenerator#installation">
    <img src="https://img.shields.io/badge/platform-iOS-lightgrey.svg" alt="Supported platforms">
  </a>
  <a href="https://github.com/pawello2222/AppIconGenerator#installation">
    <img src="https://img.shields.io/badge/SPM-compatible-brightgreen.svg" alt="Swift Package Manager">
  </a>
  <a href="https://github.com/pawello2222/AppIconGenerator/releases">
    <img src="https://img.shields.io/github/v/release/pawello2222/AppIconGenerator" alt="Release version">
  </a>
  <a href="https://github.com/pawello2222/AppIconGenerator/blob/main/LICENSE.md">
    <img src="https://img.shields.io/github/license/pawello2222/AppIconGenerator" alt="License">
  </a>
</p>

# App Icon Generator

A library for creating App Icons from SwiftUI views.

<details>
  <summary>
    <b>Table of Contents</b>
  </summary>

  1. [Installation](#installation)
  2. [Highlights](#highlights)
  3. [Icon sets](#iconsets)
  4. [Demo](#demo)
  5. [License](#license)

</details>

## Installation <a name="installation"></a>

### Requirements
* iOS 16.0+

### Swift Package Manager

App Icon Generator is available as a Swift Package.

```swift
.package(url: "https://github.com/pawello2222/AppIconGenerator.git", .upToNextMajor(from: "1.0.0"))
```

## Highlights <a name="highlights"></a>

Generate icons using `AppIconGenerator`

```swift
AppIconGenerator {
    IconView()
}
.generateIcons(for: .iOS)
```

or directly from within a SwiftUI block

```swift
IconView()
    .generateIcons(for: .iOS)
```

## Icon sets <a name="iconsets"></a>

```swift
extension IconSet {
    public var sizes: [CGFloat] {
        switch self {
        case .iOS:
            return [40, 58, 60, 76, 80, 87, 114, 120, 128, 136, 152, 167, 180, 192, 1024]
        case .macOS:
            return [16, 32, 64, 128, 256, 512, 1024]
        case .watchOS:
            return [44, 48, 55, 58, 60, 64, 66, 80, 87, 88, 92, 100, 102, 108, 172, 196, 216, 234, 258, 1024]
        case .single:
            return [1024]
        case .custom(let sizes):
            return sizes
        }
    }
}
```

## Demo <a name="demo"></a>

```swift
import AppIconGenerator
import SwiftUI

struct ContentView: View {
    var body: some View {
        IconView()
            .generateIcons(for: .iOS, name: "MyIcon")
    }
}

struct IconView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.blue
                Circle()
                    .fill(Color.red)
                    .frame(
                        width: geometry.size.width / 2,
                        height: geometry.size.height / 2
                    )
            }
        }
    }
}
```

## License <a name="license"></a>

App Icon Generator is available under the MIT license. See the [LICENSE](./LICENSE.md) file for more info.

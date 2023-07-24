// The MIT License (MIT)
//
// Copyright (c) 2020-Present Paweł Wiszenko
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import SwiftUI

public class AppIconGenerator {
    public static let shared = AppIconGenerator()

    public init() {}

    public func generateIcons<V>(from view: V, filename: String = "Icon", sizes: [Int] = appIconSizes) where V: View {
        sizes.forEach {
            view
                .edgesIgnoringSafeArea(.all)
                .environment(\.sizeCategory, .large)
                .saveToFile(name: "\(filename)\($0)", size: CGSize(width: $0, height: $0))
        }
    }
}

extension AppIconGenerator {
    public static let appIconSizes = [
        20, 29, 40, 58, 60, 76, 80, 87, 120, 152, 167, 180, 1024,
    ]
}

// MARK: - View helpers

extension View {
    public func generateIcons(filename: String = "Icon", sizes: [Int] = AppIconGenerator.appIconSizes) -> some View {
        onAppear {
            AppIconGenerator.shared.generateIcons(from: self, filename: filename, sizes: sizes)
        }
    }
}

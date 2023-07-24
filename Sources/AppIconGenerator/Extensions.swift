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

// MARK: - View

extension View {
    public func saveToFile(name: String, size: CGSize) {
        guard let imageData = asUIImage(size: size)?.pngData() else {
            print("Error retrieving PNG data of image")
            return
        }
        imageData.writeToDocumentDirectory(filename: name, fileExt: "png")
    }
}

extension View {
    public func asUIImage(size: CGSize) -> UIImage? {
        guard let rootVC = UIApplication.shared.windows.first?.rootViewController else {
            print("Could not access rootViewController")
            return nil
        }
        let scale: CGFloat = min(size.width, size.height) < 44 ? 4 : 1
        let imageVC = UIHostingController(rootView: self)
        imageVC.view.frame = CGRect(origin: .zero, size: size * scale)
        rootVC.view.insertSubview(imageVC.view, at: 0)
        defer {
            imageVC.view.removeFromSuperview()
        }
        return imageVC.view.asUIImage(size: size, scale: scale)
    }
}

// MARK: - UIView

extension UIView {
    public func asUIImage(size: CGSize, scale: CGFloat = 1) -> UIImage {
        let format = UIGraphicsImageRendererFormat(for: .init(displayScale: 1))
        return UIGraphicsImageRenderer(size: size, format: format).image { context in
            context.cgContext.scaleBy(x: 1 / scale, y: 1 / scale)
            layer.render(in: context.cgContext)
        }
    }
}

// MARK: - Data

extension Data {
    public func writeToDocumentDirectory(filename: String, fileExt: String) {
        do {
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let outputFileURL = documentDirectory
                .appendingPathComponent(filename)
                .appendingPathExtension(fileExt)
            try write(to: outputFileURL)
            print("File saved to: \(outputFileURL.path)")
        } catch {
            print("Error generating file: \(error.localizedDescription)")
        }
    }
}

// MARK: - CGSize

extension CGSize {
    fileprivate static func * (size: CGSize, value: CGFloat) -> CGSize {
        return CGSize(width: size.width * value, height: size.height * value)
    }
}

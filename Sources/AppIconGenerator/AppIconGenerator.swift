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

import OSLog
import SwiftUI

public struct AppIconGenerator<Content> where Content: View {
    private let content: () -> Content

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    @MainActor
    public func generate(iconSet: IconSet, name: String) {
        iconSet.sizes.forEach {
            generate(size: $0, name: name)
        }
    }

    @MainActor
    public func generate(size: CGFloat, name: String) {
        let view = view(size: .init(size))
        let renderer = ImageRenderer(content: view)

        let imageData: Data
        #if os(macOS)
        guard
            let tiffData = renderer.nsImage?.tiffRepresentation,
            let bitmap = NSBitmapImageRep(data: tiffData),
            let data = bitmap.representation(using: .png, properties: [:])
        else {
            Logger.main.error("Error creating data from the image.")
            return
        }
        imageData = data
        #else
        guard let data = renderer.uiImage?.pngData() else {
            Logger.main.error("Error creating data from the image.")
            return
        }
        imageData = data
        #endif

        do {
            let url = try save(data: imageData, name: name, size: size)
            Logger.main.notice("Icon saved to: \(url.path(), privacy: .public)")
        } catch {
            Logger.main.error("Error savin icons: \(error)")
        }
    }
}

// MARK: - Helpers

extension AppIconGenerator {
    private func view(size: Int) -> some View {
        content()
            .ignoresSafeArea()
            .frame(width: .init(size), height: .init(size))
            .environment(\.sizeCategory, .large)
    }

    private func save(data: Data, name: String, size: CGFloat) throws -> URL {
        let fileManager: FileManager = .default
        guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            let message = "Error accessing document directory."
            Logger.main.critical("\(message)")
            fatalError(message)
        }
        let directoryURL = documentDirectory
            .appendingPathComponent("AppIconGenerator")
            .appendingPathComponent(name)
        try fileManager.createDirectory(
            atPath: directoryURL.path,
            withIntermediateDirectories: true
        )
        let fileURL = directoryURL
            .appendingPathComponent("\(name)-\(Int(size))")
            .appendingPathExtension(for: .png)
        try data.write(to: fileURL)
        return fileURL
    }
}

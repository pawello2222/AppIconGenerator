//
//  Extensions.swift
//  AppIconGenerator
//
//  Created by Pawel Wiszenko on 15.10.2020.
//  Copyright © 2020 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public extension View {
    func saveToFile(name: String, size: CGSize) {
        guard let imageData = asUIImage(size: size)?.pngData() else {
            print("Error retrieving PNG data of image")
            return
        }
        imageData.writeToDocumentDirectory(filename: name, fileExt: "png")
    }
}

public extension View {
    func asUIImage(size: CGSize) -> UIImage? {
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

public extension UIView {
    func asUIImage(size: CGSize, scale: CGFloat = 1) -> UIImage {
        let format = UIGraphicsImageRendererFormat(for: .init(displayScale: 1))
        return UIGraphicsImageRenderer(size: size, format: format).image { context in
            context.cgContext.scaleBy(x: 1 / scale, y: 1 / scale)
            layer.render(in: context.cgContext)
        }
    }
}

public extension Data {
    func writeToDocumentDirectory(filename: String, fileExt: String) {
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

extension CGSize {
    static func * (size: CGSize, value: CGFloat) -> CGSize {
        return CGSize(width: size.width * value, height: size.height * value)
    }
}

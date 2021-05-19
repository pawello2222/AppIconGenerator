//
//  AppIconGenerator.swift
//  AppIconGenerator
//
//  Created by Pawel Wiszenko on 15.10.2020.
//  Copyright © 2020 Pawel Wiszenko. All rights reserved.
//

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
    public func generateIcons(filename: String = "Icon", sizes: [Int] = AppIconGenerator.appIconSizes) {
        AppIconGenerator.shared.generateIcons(from: self, filename: filename, sizes: sizes)
    }
}

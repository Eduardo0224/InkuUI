//
//  PlatformImage.swift
//  InkuUI
//
//  Created by Claude Code on 06/02/26.
//
//  Cross-platform image type alias for iOS, macOS, and tvOS
//

import CoreGraphics

#if canImport(UIKit)
import UIKit
public typealias PlatformImage = UIImage
#elseif canImport(AppKit)
import AppKit
public typealias PlatformImage = NSImage
#endif

// MARK: - Platform Image Extension

extension PlatformImage {

    /// Center-crops the image to a square and resizes to the specified size
    /// - Parameter size: The target side length in logical points
    /// - Returns: A square-cropped and resized image, or nil if the operation fails
    public func squareCropped(size: CGFloat = 120) -> PlatformImage? {
        guard self.size.width > 0, self.size.height > 0, size > 0 else {
            return nil
        }

        let minSide = min(self.size.width, self.size.height)
        let x = (self.size.width - minSide) / 2
        let y = (self.size.height - minSide) / 2
        let cropRect = CGRect(x: x, y: y, width: minSide, height: minSide)

        #if canImport(UIKit)
        guard let cgImage = self.cgImage else { return nil }
        let scale = self.scale
        let pixelRect = CGRect(
            x: cropRect.origin.x * scale,
            y: cropRect.origin.y * scale,
            width: cropRect.size.width * scale,
            height: cropRect.size.height * scale
        )
        guard let croppedCG = cgImage.cropping(to: pixelRect) else { return nil }
        let cropped = UIImage(cgImage: croppedCG, scale: scale, orientation: self.imageOrientation)

        #if os(watchOS)
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: size, height: size), false, 1.0)
        cropped.draw(in: CGRect(x: 0, y: 0, width: size, height: size))
        let resized = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resized
        #else
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: size, height: size))
        let resized = renderer.image { _ in
            cropped.draw(in: CGRect(x: 0, y: 0, width: size, height: size))
        }
        return resized
        #endif
        #elseif canImport(AppKit)
        let targetSize = NSSize(width: size, height: size)
        let newImage = NSImage(size: targetSize)
        newImage.lockFocus()
        draw(
            in: NSRect(origin: .zero, size: targetSize),
            from: NSRect(x: x, y: y, width: minSide, height: minSide),
            operation: .sourceOver,
            fraction: 1.0
        )
        newImage.unlockFocus()
        return newImage
        #endif
    }
}

//
//  ImageCacheServiceProtocol.swift
//  InkuUI
//
//  Created by Eduardo Andrade on 21/01/26.
//

#if canImport(UIKit)
import UIKit
typealias PlatformImage = UIImage
#elseif canImport(AppKit)
import AppKit
typealias PlatformImage = NSImage
#endif

/// Protocol for image caching service with memory and disk persistence
public protocol ImageCacheServiceProtocol: Sendable {

    // MARK: - Functions

    /// Fetches an image from cache or downloads it if not cached
    /// - Parameter url: The URL of the image to fetch
    /// - Returns: The cached or downloaded image
    /// - Throws: Error if download fails or image data is invalid
    func image(for url: URL) async throws -> PlatformImage

    /// Gets the file URL for a cached image
    /// - Parameter url: The source URL of the image
    /// - Returns: The local file URL where the image is cached
    func getFileURL(for url: URL) -> URL

    /// Clears all cached images from memory and disk
    func clearCache() async
}

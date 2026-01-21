//
//  ImageCacheService.swift
//  InkuUI
//
//  Created by Eduardo Andrade on 21/01/26.
//

import UIKit

/// Actor-based image caching service with memory and disk persistence
public actor ImageCacheService: ImageCacheServiceProtocol {

    // MARK: - Properties

    /// Shared singleton instance
    public static let shared = ImageCacheService()

    private enum ImageStatus {
        case downloading(task: Task<UIImage, any Error>)
        case downloaded(image: UIImage)
    }

    private var cache: [URL: ImageStatus] = [:]
    private var failedURLs: Set<URL> = []
    private let maxImageWidth: CGFloat = 300

    // MARK: - Initializers

    private init() {}

    // MARK: - Public Functions

    /// Fetches an image from cache or downloads it if not cached
    /// - Parameter url: The URL of the image to fetch
    /// - Returns: The cached or downloaded image
    /// - Throws: Error if download fails or image data is invalid
    public func image(for url: URL) async throws -> UIImage {
        if failedURLs.contains(url) {
            throw URLError(.badServerResponse)
        }

        if let status = cache[url] {
            return switch status {
            case .downloading(let task):
                try await task.value
            case .downloaded(let image):
                image
            }
        }

        let task = Task {
            try await downloadImage(url: url)
        }

        cache[url] = .downloading(task: task)

        do {
            let image = try await task.value

            let imageToCache: UIImage
            if let resized = await image.resize(width: maxImageWidth) {
                imageToCache = resized
            } else {
                imageToCache = image
            }

            cache[url] = .downloaded(image: imageToCache)

            try await saveImageToDisk(url: url, image: imageToCache)

            return imageToCache
        } catch {
            cache.removeValue(forKey: url)
            failedURLs.insert(url)
            throw error
        }
    }

    /// Gets the file URL for a cached image in the caches directory
    /// - Parameter url: The source URL of the image
    /// - Returns: The local file URL where the image is cached
    nonisolated public func getFileURL(for url: URL) -> URL {
        URL.cachesDirectory.appending(path: url.lastPathComponent)
    }

    /// Clears all cached images from memory and disk
    public func clearCache() async {
        cache.removeAll()

        let fileManager = FileManager.default
        guard let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return
        }

        do {
            let fileURLs = try fileManager.contentsOfDirectory(
                at: cacheDirectory,
                includingPropertiesForKeys: nil
            )

            for fileURL in fileURLs {
                try fileManager.removeItem(at: fileURL)
            }
        } catch {
            // Silently fail - cache clearing is not critical
        }
    }

    // MARK: - Private Functions

    private func downloadImage(url: URL) async throws -> UIImage {
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        guard let image = UIImage(data: data) else {
            throw URLError(.cannotDecodeContentData)
        }

        return image
    }

    private func saveImageToDisk(url: URL, image: UIImage) async throws {
        guard image.size.width > 0, image.size.height > 0 else {
            return
        }

        guard let data = image.pngData() else {
            return
        }

        let fileURL = getFileURL(for: url)
        try data.write(to: fileURL, options: .atomic)

        cache.removeValue(forKey: url)
    }
}

// MARK: - UIImage Extension

extension UIImage {

    /// Resizes the image to the specified width while maintaining aspect ratio
    /// - Parameter width: The target width
    /// - Returns: The resized image, or nil if resizing fails
    func resize(width: CGFloat) async -> UIImage? {
        guard size.width > 0, size.height > 0, width > 0 else {
            return nil
        }

        let scale = min(1, width / size.width)
        let targetSize = CGSize(
            width: size.width * scale,
            height: size.height * scale
        )

        guard targetSize.width > 0, targetSize.height > 0 else {
            return nil
        }

        return await byPreparingThumbnail(ofSize: targetSize)
    }
}

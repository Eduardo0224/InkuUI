//
//  ImageCacheService.swift
//  InkuUI
//
//  Created by Eduardo Andrade on 21/01/26.
//

import UIKit

/// Actor-based image caching service with memory and disk persistence
/// Prevents data races and provides thread-safe image caching
public actor ImageCacheService: ImageCacheServiceProtocol {

    // MARK: - Properties

    /// Shared singleton instance
    public static let shared = ImageCacheService()

    /// Image status for tracking downloads and cached images
    private enum ImageStatus {
        case downloading(task: Task<UIImage, any Error>)
        case downloaded(image: UIImage)
    }

    /// In-memory cache of images by URL
    private var cache: [URL: ImageStatus] = [:]

    /// Maximum width for image resizing (optimizes memory usage)
    private let maxImageWidth: CGFloat = 300

    // MARK: - Initializers

    private init() {}

    // MARK: - Public Functions

    /// Fetches an image from cache or downloads it if not cached
    /// Implements task deduplication to prevent multiple simultaneous downloads of the same image
    public func image(for url: URL) async throws -> UIImage {
        // Check if image is already cached or being downloaded
        if let status = cache[url] {
            return switch status {
            case .downloading(let task):
                // Wait for existing download to complete
                try await task.value
            case .downloaded(let image):
                // Return cached image
                image
            }
        }

        // Start new download task
        let task = Task {
            try await downloadImage(url: url)
        }

        // Store task in cache to prevent duplicate downloads
        cache[url] = .downloading(task: task)

        do {
            // Wait for download to complete
            let image = try await task.value

            // Update cache with downloaded image
            cache[url] = .downloaded(image: image)

            // Save to disk asynchronously
            try await saveImageToDisk(url: url, image: image)

            return image
        } catch {
            // Remove from cache on error
            cache.removeValue(forKey: url)
            throw error
        }
    }

    /// Gets the file URL for a cached image in the caches directory
    nonisolated public func getFileURL(for url: URL) -> URL {
        URL.cachesDirectory.appending(path: url.lastPathComponent)
    }

    /// Clears all cached images from memory and disk
    public func clearCache() async {
        // Clear memory cache
        cache.removeAll()

        // Clear disk cache
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
            print("[ImageCacheService] Error clearing disk cache: \(error)")
        }
    }

    // MARK: - Private Functions

    /// Downloads an image from the given URL
    private func downloadImage(url: URL) async throws -> UIImage {
        let (data, response) = try await URLSession.shared.data(from: url)

        // Validate response
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        // Convert data to UIImage
        guard let image = UIImage(data: data) else {
            throw URLError(.cannotDecodeContentData)
        }

        return image
    }

    /// Saves the image to disk with resizing for optimization
    private func saveImageToDisk(url: URL, image: UIImage) async throws {
        // Resize image to optimize storage
        guard let resizedImage = await image.resize(width: maxImageWidth),
              let data = resizedImage.pngData() else {
            return
        }

        // Write to disk
        let fileURL = getFileURL(for: url)
        try data.write(to: fileURL, options: .atomic)

        // Remove from memory cache after saving to disk to free memory
        cache.removeValue(forKey: url)
    }
}

// MARK: - UIImage Extension

extension UIImage {

    /// Resizes the image to the specified width while maintaining aspect ratio
    /// - Parameter width: The target width
    /// - Returns: The resized image, or nil if resizing fails
    func resize(width: CGFloat) async -> UIImage? {
        let scale = min(1, width / size.width)
        let targetSize = CGSize(
            width: width,
            height: size.height * scale
        )
        return await byPreparingThumbnail(ofSize: targetSize)
    }
}

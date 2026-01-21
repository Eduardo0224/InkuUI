//
//  InkuCoverImage.swift
//  InkuUI
//
//  Created by Eduardo Andrade on 25/12/25.
//

import SwiftUI

/// An async image component specialized for manga/comic cover artwork display
///
/// InkuCoverImage handles image loading states with automatic skeleton shimmer
/// during fetch, error fallback with photo icon, and customizable corner radius.
/// Uses ImageCacheService for efficient memory and disk caching.
///
/// Example usage:
/// ```swift
/// InkuCoverImage(url: coverURL)
/// InkuCoverImage(url: coverURL, cornerRadius: 8)
/// InkuCoverImage(url: nil, isLoading: true)  // Skeleton state
/// ```
public struct InkuCoverImage: View {

    // MARK: - Properties

    let url: URL?
    var cornerRadius: CGFloat
    let isLoading: Bool

    // MARK: - States

    @State private var image: UIImage?
    @State private var loadError: Error?
    @State private var hasAttemptedLoad = false

    // MARK: - Initializers

    public init(
        url: URL?,
        cornerRadius: CGFloat = InkuRadius.radius12,
        isLoading: Bool = false
    ) {
        self.url = url
        self.cornerRadius = cornerRadius
        self.isLoading = isLoading
    }

    // MARK: - Body

    public var body: some View {
        Group {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else if loadError != nil {
                placeholder
                    .overlay {
                        Image(systemName: "photo")
                            .foregroundStyle(Color.inkuTextTertiary)
                    }
            } else {
                placeholder
                    .inkuSkeleton(shouldShowShimmer)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .task(id: url) {
            await loadImage()
        }
        .onChange(of: url) { _, _ in
            // Reset load attempt only when URL actually changes
            hasAttemptedLoad = false
            image = nil
            loadError = nil
        }
    }

    // MARK: - Private Properties

    private var shouldShowShimmer: Bool {
        // Show shimmer if forced by isLoading, OR if there's a URL being loaded
        isLoading || url != nil
    }

    // MARK: - Private Views

    private var placeholder: some View {
        Rectangle()
            .fill(Color.inkuSurfaceSecondary)
    }

    // MARK: - Private Functions

    private func loadImage() async {
        guard let url else {
            image = nil
            return
        }

        // Prevent infinite retry loops - only attempt once per URL
        guard !hasAttemptedLoad else {
            return
        }

        hasAttemptedLoad = true
        loadError = nil

        do {
            // Check if image exists in disk cache first
            let fileURL = ImageCacheService.shared.getFileURL(for: url)
            if FileManager.default.fileExists(atPath: fileURL.path()) {
                let data = try Data(contentsOf: fileURL)
                if let cachedImage = UIImage(data: data) {
                    // Validate cached image has valid dimensions
                    guard cachedImage.size.width > 0, cachedImage.size.height > 0 else {
                        print("[InkuCoverImage] ❌ Invalid cached image dimensions (\(cachedImage.size)), removing: \(fileURL.lastPathComponent)")
                        try? FileManager.default.removeItem(at: fileURL)
                        // Continue to download fresh image
                        let downloadedImage = try await ImageCacheService.shared.image(for: url)
                        image = downloadedImage
                        return
                    }
                    image = cachedImage
                    return
                }
            }

            // Download and cache the image
            let downloadedImage = try await ImageCacheService.shared.image(for: url)
            image = downloadedImage
        } catch {
            loadError = error

            // Provide detailed error logging based on error type
            if let urlError = error as? URLError {
                switch urlError.code {
                case .badServerResponse:
                    print("[InkuCoverImage] ❌ Bad server response (404/500) for: \(url.lastPathComponent)")
                case .cannotDecodeContentData:
                    print("[InkuCoverImage] ❌ Invalid image data for: \(url.lastPathComponent)")
                case .notConnectedToInternet:
                    print("[InkuCoverImage] ❌ No internet connection for: \(url.lastPathComponent)")
                case .timedOut:
                    print("[InkuCoverImage] ❌ Request timed out for: \(url.lastPathComponent)")
                default:
                    print("[InkuCoverImage] ❌ Network error (\(urlError.code.rawValue)) for: \(url.lastPathComponent)")
                }
            } else {
                print("[InkuCoverImage] ❌ Unexpected error loading image: \(error)")
            }
        }
    }
}

// MARK: - Previews

#Preview("Cover Image", traits: .sizeThatFitsLayout) {
    VStack(spacing: InkuSpacing.spacing16) {
        InkuCoverImage(url: URL(string: "https://example.com/cover.jpg"))
            .frame(width: 160, height: 240)

        InkuCoverImage(url: nil)
            .frame(width: 160, height: 240)
    }
    .padding()
    .background(Color.inkuSurface)
}

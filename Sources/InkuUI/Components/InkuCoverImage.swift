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
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                placeholder
                    .inkuSkeleton(shouldShowShimmer)
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            case .failure:
                placeholder
                    .overlay {
                        Image(systemName: "photo")
                            .foregroundStyle(Color.inkuTextTertiary)
                    }
            @unknown default:
                placeholder
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
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

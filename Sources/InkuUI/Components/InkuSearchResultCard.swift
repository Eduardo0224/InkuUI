//
//  InkuSearchResultCard.swift
//  InkuUI
//
//  Created by Eduardo Andrade on 03/01/26.
//

import SwiftUI

/// A specialized card component for displaying search results
///
/// InkuSearchResultCard is optimized for search result grids, showing key information
/// that helps users quickly identify and evaluate manga: cover, title, and subtitle.
///
/// Unlike InkuMangaCard (minimal info) and InkuMangaRow (detailed list), this component
/// strikes a balance with medium information density, perfect for 2-column search grids.
///
/// Example usage:
/// ```swift
/// InkuSearchResultCard(
///     imageURL: coverURL,
///     title: "One Piece",
///     subtitle: "ワンピース",
///     badge: "Shounen"
/// )
/// ```
public struct InkuSearchResultCard: View {

    // MARK: - Properties

    let imageURL: URL?
    let title: String
    let subtitle: String?
    let badge: String?
    let isLoading: Bool

    // MARK: - Initializers

    public init(
        imageURL: URL?,
        title: String,
        subtitle: String? = nil,
        badge: String? = nil,
        isLoading: Bool = false
    ) {
        self.imageURL = imageURL
        self.title = title
        self.subtitle = subtitle
        self.badge = badge
        self.isLoading = isLoading
    }

    // MARK: - Body

    public var body: some View {
        InkuCoverImage(url: imageURL, isLoading: isLoading)
            .aspectRatio(4/5, contentMode: .fit)
            .overlay(alignment: .topTrailing) {
                if let badge {
                    InkuBadge(text: badge, isLoading: isLoading)
                        .padding(InkuSpacing.spacing8)
                }
            }
            .overlay(alignment: .bottom) {
                // Info overlay with gradient background
                titlesView
                    .inkuSkeleton(isLoading)
                    .padding(InkuSpacing.spacing12)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        LinearGradient(
                            colors: [
                                Color.black.opacity(0),
                                Color.black.opacity(0.7),
                                Color.black.opacity(0.85)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
            }
            .clipShape(RoundedRectangle(cornerRadius: InkuRadius.radius12))
            .shadow(color: .black.opacity(0.1), radius: InkuRadius.radius8, y: 2)
    }

    // MARK: - Private Views

    private var titlesView: some View {
        VStack(alignment: .leading, spacing: InkuSpacing.spacing4) {
            Text(title)
                .font(.inkuHeadline)
                .foregroundStyle(.white)
                .lineLimit(2)

            if let subtitle {
                Text(subtitle)
                    .font(.inkuCaption)
                    .foregroundStyle(.white.opacity(0.8))
                    .lineLimit(1)
            }
        }
    }
}

// MARK: - Previews

#Preview("Search Result Card - Full Data") {
    InkuSearchResultCard(
        imageURL: URL(string: "https://example.com/cover.jpg"),
        title: "One Piece",
        subtitle: "ワンピース",
        badge: "Shounen"
    )
    .frame(width: 180)
    .padding()
    .background(Color.inkuSurface)
}

#Preview("Search Result Card - Loading") {
    InkuSearchResultCard(
        imageURL: nil,
        title: "Loading Title",
        subtitle: "Loading Subtitle",
        badge: "Genre",
        isLoading: true
    )
    .frame(width: 180)
    .padding()
    .background(Color.inkuSurface)
}

#Preview("Search Result Card - Minimal Data") {
    InkuSearchResultCard(
        imageURL: nil,
        title: "Attack on Titan"
    )
    .frame(width: 180)
    .padding()
    .background(Color.inkuSurface)
}

#Preview("Search Result Grid") {
    ScrollView {
        LazyVGrid(
            columns: Array(repeating: GridItem(.flexible(), spacing: InkuSpacing.spacing12), count: 2),
            spacing: InkuSpacing.spacing12
        ) {
            ForEach(0..<6) { index in
                InkuSearchResultCard(
                    imageURL: nil,
                    title: "Manga Title \(index + 1)",
                    subtitle: "日本語タイトル",
                    badge: ["Shounen", "Seinen", "Josei"][index % 3],
                    isLoading: index < 2
                )
            }
        }
        .padding()
    }
    .background(Color.inkuSurface)
    #if os(macOS)
    .frame(width: 320, height: 580)
    #elseif os(tvOS)
    .frame(width: 1_000)
    #endif
}

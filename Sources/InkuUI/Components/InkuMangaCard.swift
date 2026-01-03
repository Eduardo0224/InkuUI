//
//  InkuMangaCard.swift
//  InkuUI
//
//  Created by Eduardo Andrade on 25/12/25.
//

import SwiftUI

/// A vertical card component for displaying manga/comic information with cover art
///
/// InkuMangaCard combines cover image, title, subtitle, and optional badge in a
/// vertical card layout. Supports skeleton loading state for all subcomponents.
///
/// Example usage:
/// ```swift
/// InkuMangaCard(
///     imageURL: coverURL,
///     title: "One Piece",
///     subtitle: "Eiichiro Oda",
///     badge: "Shounen"
/// )
/// InkuMangaCard(imageURL: nil, title: "Loading...", isLoading: true)
/// ```
public struct InkuMangaCard: View {

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
        VStack(alignment: .leading, spacing: InkuSpacing.spacing8) {
            // Cover image - handles its own loading state via AsyncImage phase
            InkuCoverImage(url: imageURL, isLoading: isLoading)
                .aspectRatio(2/3, contentMode: .fit)

            // Info
            VStack(alignment: .leading, spacing: InkuSpacing.spacing4) {
                Text(title)
                    .font(.inkuHeadline)
                    .foregroundStyle(Color.inkuText)
                    .lineLimit(2)

                if let subtitle {
                    Text(subtitle)
                        .font(.inkuCaption)
                        .foregroundStyle(Color.inkuTextSecondary)
                        .lineLimit(1)
                }
            }
            .inkuSkeleton(isLoading)
            .padding(.horizontal, InkuSpacing.spacing8)
            .padding(.bottom, InkuSpacing.spacing12)
        }
        .background(Color.inkuSurfaceElevated)
        .clipShape(RoundedRectangle(cornerRadius: InkuRadius.radius12))
        .shadow(color: .black.opacity(0.08), radius: InkuRadius.radius4, y: 2)
        .overlay(alignment: .topTrailing) {
            if let badge {
                InkuBadge(text: badge, isLoading: isLoading)
                    .padding(InkuSpacing.spacing8)
            }
        }
    }
}

// MARK: - Previews

#Preview("Manga Card", traits: .sizeThatFitsLayout) {
    InkuMangaCard(
        imageURL: URL(string: "https://example.com/cover.jpg"),
        title: "One Piece",
        subtitle: "Eiichiro Oda",
        badge: "Shounen"
    )
    .frame(width: 160)
    .padding()
    .background(Color.inkuSurface)
}

#Preview("Manga Card - Loading", traits: .sizeThatFitsLayout) {
    InkuMangaCard(
        imageURL: nil,
        title: "Loading Title",
        subtitle: "Loading Author",
        badge: "Genre",
        isLoading: true
    )
    .frame(width: 160)
    .padding()
    .background(Color.inkuSurface)
}

#Preview("Manga Card - No Badge", traits: .sizeThatFitsLayout) {
    InkuMangaCard(
        imageURL: nil,
        title: "Attack on Titan",
        subtitle: "Hajime Isayama"
    )
    .frame(width: 160)
    .padding()
    .background(Color.inkuSurface)
}

#Preview("Manga Card Grid", traits: .sizeThatFitsLayout) {
    ScrollView {
        LazyVGrid(
            columns: [GridItem(.adaptive(minimum: 140), spacing: InkuSpacing.spacing16)],
            spacing: InkuSpacing.spacing16
        ) {
            ForEach(0..<6) { index in
                InkuMangaCard(
                    imageURL: nil,
                    title: "Manga Title \(index + 1)",
                    subtitle: "Author Name",
                    badge: index % 2 == 0 ? "Shounen" : nil,
                    isLoading: index < 3
                )
            }
        }
        .padding()
        .background(Color.inkuSurface)
    }
}

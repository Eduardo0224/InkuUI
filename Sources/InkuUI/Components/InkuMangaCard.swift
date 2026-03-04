//
//  InkuMangaCard.swift
//  InkuUI
//
//  Created by Eduardo Andrade on 25/12/25.
//

import SwiftUI

/// A vertical card component for displaying manga/comic information with cover art
///
/// InkuMangaCard combines cover image, title, subtitle, score, genre badge, and status
/// in a vertical card layout optimized for grid views. Supports skeleton loading state.
///
/// Example usage:
/// ```swift
/// InkuMangaCard(
///     imageURL: coverURL,
///     title: "One Piece",
///     subtitle: "ワンピース",
///     score: 9.1,
///     genre: "Shounen",
///     status: .publishing
/// )
/// InkuMangaCard(imageURL: nil, title: "Loading...", isLoading: true)
/// ```
public struct InkuMangaCard: View {

    public enum Status {
        case publishing
        case completed
        case hiatus
        case discontinued

        var displayText: String {
            switch self {
            case .publishing: return "Publishing"
            case .completed: return "Completed"
            case .hiatus: return "Hiatus"
            case .discontinued: return "Discontinued"
            }
        }

        var color: Color {
            switch self {
            case .publishing: return .green
            case .completed: return .blue
            case .hiatus: return .orange
            case .discontinued: return .red
            }
        }
    }

    // MARK: - Properties

    let imageURL: URL?
    let title: String
    let subtitle: String?
    let score: Double?
    let genre: String?
    let status: Status?
    let isLoading: Bool

    // MARK: - Initializers

    public init(
        imageURL: URL?,
        title: String,
        subtitle: String? = nil,
        score: Double? = nil,
        genre: String? = nil,
        status: Status? = nil,
        isLoading: Bool = false
    ) {
        self.imageURL = imageURL
        self.title = title
        self.subtitle = subtitle
        self.score = score
        self.genre = genre
        self.status = status
        self.isLoading = isLoading
    }

    // MARK: - Body

    public var body: some View {
        VStack(alignment: .leading, spacing: InkuSpacing.spacing8) {
            // Cover with genre badge overlay
            coverView

            // Info section
            VStack(alignment: .leading, spacing: InkuSpacing.spacing4) {
                // Title + subtitle
                titlesView

                // Score
                if let score {
                    scoreView(score: score)
                }

                // Status
                if let status {
                    statusView(status: status)
                }
            }
            .inkuSkeleton(isLoading)
            .padding(.horizontal, InkuSpacing.spacing12)
            .padding(.bottom, InkuSpacing.spacing12)
        }
        .background(Color.inkuSurfaceElevated)
        .clipShape(RoundedRectangle(cornerRadius: InkuRadius.radius12))
        .shadow(color: .black.opacity(0.08), radius: InkuRadius.radius4, y: 2)
        #if os(visionOS)
        .scaleHoverEffect()
        #endif
    }

    // MARK: - Private Views

    private var coverView: some View {
        InkuCoverImage(url: imageURL, maxWidth: 160, isLoading: isLoading)
            .aspectRatio(2/3, contentMode: .fit)
            .overlay(alignment: .topTrailing) {
                if let genre {
                    InkuBadge(text: genre, isLoading: isLoading)
                        .padding(InkuSpacing.spacing8)
                }
            }
    }

    private var titlesView: some View {
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
    }

    private func scoreView(score: Double) -> some View {
        HStack(spacing: InkuSpacing.spacing4) {
            Image(systemName: "star.fill")
                .font(.caption)
                .foregroundStyle(.yellow)
            Text(score.formatted(.number.precision(.fractionLength(1))))
                .font(.inkuCaption)
                .foregroundStyle(Color.inkuTextSecondary)
        }
    }

    private func statusView(status: Status) -> some View {
        HStack(spacing: InkuSpacing.spacing4) {
            Circle()
                .fill(status.color)
                .frame(width: InkuDimensions.separatorWidth, height: InkuDimensions.separatorWidth)
            Text(status.displayText)
                .font(.inkuCaptionSmall)
                .foregroundStyle(Color.inkuTextSecondary)
        }
    }
}

// MARK: - Previews

#Preview("Manga Card - Full Data", traits: .sizeThatFitsLayout) {
    InkuMangaCard(
        imageURL: URL(string: "https://example.com/cover.jpg"),
        title: "One Piece",
        subtitle: "ワンピース",
        score: 9.1,
        genre: "Shounen",
        status: .publishing
    )
    .frame(width: 160)
    .padding()
    .background(Color.inkuSurface)
}

#Preview("Manga Card - Loading", traits: .sizeThatFitsLayout) {
    InkuMangaCard(
        imageURL: nil,
        title: "Loading Title",
        subtitle: "Loading Subtitle",
        score: 8.5,
        genre: "Genre",
        status: .completed,
        isLoading: true
    )
    .frame(width: 160)
    .padding()
    .background(Color.inkuSurface)
}

#Preview("Manga Card - Minimal Data", traits: .sizeThatFitsLayout) {
    InkuMangaCard(
        imageURL: nil,
        title: "Attack on Titan",
        subtitle: "Hajime Isayama",
        score: 8.5
    )
    .frame(width: 160)
    .padding()
    .background(Color.inkuSurface)
}

#Preview("Manga Card Grid") {

    let minimumGridSize: CGFloat = {
        #if os(tvOS)
        200
        #else
        140
        #endif
    }()

    ScrollView {
        LazyVGrid(
            columns: [GridItem(.adaptive(minimum: minimumGridSize), spacing: InkuSpacing.spacing16)],
            spacing: InkuSpacing.spacing16
        ) {
            ForEach(0..<6) { index in
                InkuMangaCard(
                    imageURL: nil,
                    title: "Manga Title \(index + 1)",
                    subtitle: "日本語タイトル",
                    score: Double.random(in: 7.0...9.5),
                    genre: ["Shounen", "Seinen", "Josei"][index % 3],
                    status: [.publishing, .completed, .hiatus, .discontinued][index % 4],
                    isLoading: index < 3
                )
            }
        }
        .padding()
        .background(Color.inkuSurface)
    }
    #if os(macOS)
    .frame(width: 560)
    #elseif os(visionOS)
    .frame(width: 800)
    #endif
}

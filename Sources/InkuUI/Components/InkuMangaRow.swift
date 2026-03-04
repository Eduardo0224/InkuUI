//
//  InkuMangaRow.swift
//  InkuUI
//
//  Created by Eduardo Andrade on 28/12/25.
//

import SwiftUI

/// A horizontal row component for displaying manga/comic information in lists
///
/// InkuMangaRow provides a horizontal layout optimized for list views, combining
/// cover thumbnail, title hierarchy, rating, genres, and status indicator.
///
/// The component displays all genres provided - limit them before passing if needed.
///
/// Example usage:
/// ```swift
/// InkuMangaRow(
///     imageURL: coverURL,
///     title: "One Piece",
///     subtitle: "ワンピース",
///     score: 9.1,
///     genres: Array(manga.genres.prefix(3)), // App decides limit
///     status: .publishing
/// )
///
/// InkuMangaRow(
///     imageURL: nil,
///     title: "Loading...",
///     genres: [],
///     isLoading: true
/// )
/// ```
public struct InkuMangaRow: View {

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
    let genres: [String]
    let status: Status?
    let isLoading: Bool

    // MARK: - Initializers

    public init(
        imageURL: URL?,
        title: String,
        subtitle: String? = nil,
        score: Double? = nil,
        genres: [String] = [],
        status: Status? = nil,
        isLoading: Bool = false
    ) {
        self.imageURL = imageURL
        self.title = title
        self.subtitle = subtitle
        self.score = score
        self.genres = genres
        self.status = status
        self.isLoading = isLoading
    }

    // MARK: - Body

    public var body: some View {
        HStack(alignment: .top, spacing: InkuSpacing.spacing12) {
            // Cover thumbnail
            InkuCoverImage(url: imageURL, cornerRadius: InkuRadius.radius8, maxWidth: InkuDimensions.coverThumbnailWidth, isLoading: isLoading)
                .frame(width: InkuDimensions.coverThumbnailWidth, height: InkuDimensions.coverThumbnailHeight)

            // Content
            VStack(alignment: .leading, spacing: InkuSpacing.spacing8) {
                // Titles
                titlesView
                    .inkuSkeleton(isLoading)

                // Score
                if let score {
                    scoreView(score: score)
                        .inkuSkeleton(isLoading)
                }

                // Genres
                if !genres.isEmpty {
                    genresView
                }

                // Status
                if let status {
                    statusView(status: status)
                        .inkuSkeleton(isLoading)
                }
            }
        }
        .padding(InkuSpacing.spacing16)
        .inkuHoverCard()
    }

    // MARK: - Private Views

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

    private var genresView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: InkuSpacing.spacing8) {
                ForEach(genres, id: \.self) { genre in
                    InkuBadge(text: genre, style: .secondary, isLoading: isLoading)
                }
            }
        }
        .scrollDisabled(isLoading)
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

#Preview("Manga Row - Full Data", traits: .sizeThatFitsLayout) {
    InkuMangaRow(
        imageURL: URL(string: "https://example.com/cover.jpg"),
        title: "One Piece",
        subtitle: "ワンピース • Eiichiro Oda",
        score: 9.1,
        genres: ["Shounen", "Action", "Adventure", "Fantasy"],
        status: .publishing
    )
    .padding()
    .background(Color.inkuSurface)
}

#Preview("Manga Row - Minimal Data", traits: .sizeThatFitsLayout) {
    InkuMangaRow(
        imageURL: nil,
        title: "Attack on Titan",
        score: 8.5,
        genres: ["Shounen"],
        status: .completed
    )
    .padding()
    .background(Color.inkuSurface)
}

#Preview("Manga Row - Loading", traits: .sizeThatFitsLayout) {
    InkuMangaRow(
        imageURL: nil,
        title: "Loading Title...",
        subtitle: "Loading Subtitle...",
        score: 8.3,
        genres: ["Genre1", "Genre2"],
        status: .completed,
        isLoading: true
    )
    .padding()
    .background(Color.inkuSurface)
}

#Preview("Manga Row List", traits: .sizeThatFitsLayout) {
    ScrollView {
        VStack(spacing: InkuSpacing.spacing16) {
            InkuMangaRow(
                imageURL: nil,
                title: "Naruto",
                subtitle: "ナルト",
                score: 8.3,
                genres: ["Shounen", "Action"],
                status: .completed
            )

            InkuMangaRow(
                imageURL: nil,
                title: "Hunter x Hunter",
                subtitle: "ハンター×ハンター",
                score: 9.0,
                genres: ["Shounen", "Adventure"],
                status: .hiatus
            )

            InkuMangaRow(
                imageURL: nil,
                title: "Berserk",
                score: 9.4,
                genres: ["Seinen", "Dark Fantasy"],
                status: .discontinued
            )
        }
        .padding()
    }
    .background(Color.inkuSurface)
}

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
/// that helps users quickly identify and evaluate manga: cover, score, title, and status.
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
///     score: 9.1,
///     badge: "Shounen",
///     status: .publishing
/// )
/// ```
public struct InkuSearchResultCard: View {

    // MARK: - Types

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
    let badge: String?
    let status: Status?
    let isLoading: Bool

    // MARK: - Initializers

    public init(
        imageURL: URL?,
        title: String,
        subtitle: String? = nil,
        score: Double? = nil,
        badge: String? = nil,
        status: Status? = nil,
        isLoading: Bool = false
    ) {
        self.imageURL = imageURL
        self.title = title
        self.subtitle = subtitle
        self.score = score
        self.badge = badge
        self.status = status
        self.isLoading = isLoading
    }

    // MARK: - Body

    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Cover image with badge overlay
            InkuCoverImage(url: imageURL, isLoading: isLoading)
                .aspectRatio(2/3, contentMode: .fit)
                .overlay(alignment: .topTrailing) {
                    if let badge {
                        InkuBadge(text: badge, isLoading: isLoading)
                            .padding(InkuSpacing.spacing8)
                    }
                }

            // Info section
            VStack(alignment: .leading, spacing: InkuSpacing.spacing8) {
                // Score (prominent)
                if let score {
                    scoreView(score: score)
                        .inkuSkeleton(isLoading)
                }

                // Title and subtitle
                titlesView
                    .inkuSkeleton(isLoading)

                // Status
                if let status {
                    statusView(status: status)
                        .inkuSkeleton(isLoading)
                }
            }
            .padding(InkuSpacing.spacing12)
        }
        .background(Color.inkuSurfaceElevated)
        .clipShape(RoundedRectangle(cornerRadius: InkuRadius.radius12))
        .shadow(color: .black.opacity(0.08), radius: InkuRadius.radius4, y: 2)
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
                .font(.inkuCaption)
                .foregroundStyle(.yellow)
            Text(score.formatted(.number.precision(.fractionLength(1))))
                .font(.inkuBodySmall)
                .fontWeight(.semibold)
                .foregroundStyle(Color.inkuText)
        }
    }

    private func statusView(status: Status) -> some View {
        HStack(spacing: InkuSpacing.spacing4) {
            Circle()
                .fill(status.color)
                .frame(width: 6, height: 6)
            Text(status.displayText)
                .font(.inkuCaptionSmall)
                .foregroundStyle(Color.inkuTextSecondary)
        }
    }
}

// MARK: - Previews

#Preview("Search Result Card - Full Data") {
    InkuSearchResultCard(
        imageURL: URL(string: "https://example.com/cover.jpg"),
        title: "One Piece",
        subtitle: "ワンピース",
        score: 9.1,
        badge: "Shounen",
        status: .publishing
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
        score: 8.5,
        badge: "Genre",
        status: .publishing,
        isLoading: true
    )
    .frame(width: 180)
    .padding()
    .background(Color.inkuSurface)
}

#Preview("Search Result Card - Minimal Data") {
    InkuSearchResultCard(
        imageURL: nil,
        title: "Attack on Titan",
        score: 8.8,
        status: .completed
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
                    score: Double.random(in: 7.0...10.0),
                    badge: ["Shounen", "Seinen", "Josei"][index % 3],
                    status: [.publishing, .completed, .hiatus][index % 3],
                    isLoading: index < 2
                )
            }
        }
        .padding()
    }
    .background(Color.inkuSurface)
}

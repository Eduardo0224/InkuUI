//
//  InkuStatCard.swift
//  InkuUI
//
//  Created by Eduardo Andrade on 30/12/25.
//

import SwiftUI

/// A card component for displaying statistical information with icon and label
///
/// InkuStatCard shows a statistic in a card format with an optional icon, a prominent value,
/// and a descriptive label. Supports two sizes: compact for inline stats and large for hero displays.
///
/// Example usage:
/// ```swift
/// // Compact (inline stats)
/// InkuStatCard(
///     icon: "star.fill",
///     value: "9.1",
///     label: "Score",
///     size: .compact,
///     accentColor: .yellow
/// )
///
/// // Large (dashboard hero stats)
/// InkuStatCard(
///     icon: "books.vertical.fill",
///     value: "42",
///     label: "Total Mangas",
///     size: .large,
///     accentColor: .inkuAccent
/// )
/// ```
public struct InkuStatCard: View {

    // MARK: - Size

    public enum Size {
        case compact
        case large
    }

    // MARK: - Properties

    let icon: String?
    let value: String
    let label: String
    let size: Size
    let accentColor: Color?

    // MARK: - Initializers

    public init(
        icon: String? = nil,
        value: String,
        label: String,
        size: Size = .compact,
        accentColor: Color? = nil
    ) {
        self.icon = icon
        self.value = value
        self.label = label
        self.size = size
        self.accentColor = accentColor
    }

    // MARK: - Body

    public var body: some View {
        VStack(spacing: spacing) {
            if let icon {
                Image(systemName: icon)
                    .font(iconFont)
                    .foregroundStyle(accentColor ?? Color.inkuAccent)
            }

            VStack(spacing: InkuSpacing.spacing4) {
                Text(value)
                    .font(valueFont)
                    .foregroundStyle(Color.inkuText)
                    .lineLimit(1)

                Text(label)
                    .font(labelFont)
                    .foregroundStyle(Color.inkuTextSecondary)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(padding)
        .background(Color.inkuSurfaceElevated)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }

    // MARK: - Private Computed Properties

    private var spacing: CGFloat {
        switch size {
        case .compact:
            return InkuSpacing.spacing8
        case .large:
            return InkuSpacing.spacing12
        }
    }

    private var iconFont: Font {
        switch size {
        case .compact:
            return .title2
        case .large:
            return .system(size: 32)
        }
    }

    private var valueFont: Font {
        switch size {
        case .compact:
            return .inkuHeadline
        case .large:
            return .system(size: 32, weight: .bold)
        }
    }

    private var labelFont: Font {
        switch size {
        case .compact:
            return .inkuCaptionSmall
        case .large:
            return .inkuCaption
        }
    }

    private var padding: CGFloat {
        switch size {
        case .compact:
            return InkuSpacing.spacing12
        case .large:
            return InkuSpacing.spacing20
        }
    }

    private var cornerRadius: CGFloat {
        switch size {
        case .compact:
            return InkuRadius.radius12
        case .large:
            return InkuRadius.radius16
        }
    }
}

// MARK: - Previews

#Preview("Stat Card - Compact", traits: .sizeThatFitsLayout) {
    HStack(spacing: InkuSpacing.spacing12) {
        InkuStatCard(
            icon: "star.fill",
            value: "9.1",
            label: "Score",
            size: .compact,
            accentColor: .yellow
        )

        InkuStatCard(
            icon: "book.fill",
            value: "25",
            label: "Volumes",
            size: .compact,
            accentColor: .blue
        )

        InkuStatCard(
            icon: "doc.text.fill",
            value: "1097",
            label: "Chapters",
            size: .compact,
            accentColor: .green
        )

        InkuStatCard(
            icon: "checkmark.circle.fill",
            value: "Publishing",
            label: "Status",
            size: .compact
        )
    }
    .padding()
    .background(Color.inkuSurface)
}

#Preview("Stat Card - Large", traits: .sizeThatFitsLayout) {
    LazyVGrid(
        columns: [
            GridItem(.flexible()),
            GridItem(.flexible())
        ],
        spacing: InkuSpacing.spacing16
    ) {
        InkuStatCard(
            icon: "books.vertical.fill",
            value: "42",
            label: "Total Mangas",
            size: .large,
            accentColor: .inkuAccent
        )

        InkuStatCard(
            icon: "book.fill",
            value: "1,247",
            label: "Total Volumes",
            size: .large,
            accentColor: .inkuAccentStrong
        )
    }
    .padding()
    .background(Color.inkuSurface)
}

#Preview("Stat Card - Mixed Sizes", traits: .sizeThatFitsLayout) {
    VStack(spacing: InkuSpacing.spacing16) {
        // Large stats
        HStack(spacing: InkuSpacing.spacing12) {
            InkuStatCard(
                icon: "chart.bar.fill",
                value: "2,450",
                label: "Total Items",
                size: .large,
                accentColor: .blue
            )

            InkuStatCard(
                icon: "checkmark.circle.fill",
                value: "89%",
                label: "Complete",
                size: .large,
                accentColor: .green
            )
        }

        // Compact stats
        HStack(spacing: InkuSpacing.spacing12) {
            InkuStatCard(
                icon: "star.fill",
                value: "9.21",
                label: "Score",
                size: .compact,
                accentColor: .yellow
            )

            InkuStatCard(
                value: "1997",
                label: "Started",
                size: .compact
            )

            InkuStatCard(
                value: "Present",
                label: "Ended",
                size: .compact
            )
        }
    }
    .padding()
    .background(Color.inkuSurface)
}

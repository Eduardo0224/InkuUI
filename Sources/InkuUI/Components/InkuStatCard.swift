//
//  InkuStatCard.swift
//  InkuUI
//
//  Created by Eduardo Andrade on 30/12/25.
//

import SwiftUI

/// A compact card component for displaying statistical information with icon and label
///
/// InkuStatCard shows a statistic in a card format with an optional icon, a prominent value,
/// and a descriptive label. Perfect for dashboards, detail views, and summary sections.
///
/// Example usage:
/// ```swift
/// InkuStatCard(
///     icon: "star.fill",
///     value: "9.1",
///     label: "Score",
///     accentColor: .yellow
/// )
///
/// InkuStatCard(
///     icon: "book.fill",
///     value: "25",
///     label: "Volumes"
/// )
///
/// InkuStatCard(
///     value: "1997",
///     label: "Started"
/// )
/// ```
public struct InkuStatCard: View {

    // MARK: - Properties

    let icon: String?
    let value: String
    let label: String
    let accentColor: Color?

    // MARK: - Initializers

    public init(
        icon: String? = nil,
        value: String,
        label: String,
        accentColor: Color? = nil
    ) {
        self.icon = icon
        self.value = value
        self.label = label
        self.accentColor = accentColor
    }

    // MARK: - Body

    public var body: some View {
        VStack(spacing: InkuSpacing.spacing8) {
            if let icon {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundStyle(accentColor ?? Color.inkuAccent)
            }

            Text(value)
                .font(.inkuHeadline)
                .foregroundStyle(Color.inkuText)
                .lineLimit(1)

            Text(label)
                .font(.inkuCaptionSmall)
                .foregroundStyle(Color.inkuTextSecondary)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity)
        .padding(InkuSpacing.spacing12)
        .inkuCard()
    }
}

// MARK: - Previews

#Preview("Stat Card - With Icon", traits: .sizeThatFitsLayout) {
    HStack(spacing: InkuSpacing.spacing12) {
        InkuStatCard(
            icon: "star.fill",
            value: "9.1",
            label: "Score",
            accentColor: .yellow
        )

        InkuStatCard(
            icon: "book.fill",
            value: "25",
            label: "Volumes",
            accentColor: .blue
        )

        InkuStatCard(
            icon: "doc.text.fill",
            value: "1097",
            label: "Chapters",
            accentColor: .green
        )

        InkuStatCard(
            icon: "checkmark.circle.fill",
            value: "Publishing",
            label: "Status"
        )
    }
    .padding()
    .background(Color.inkuSurface)
}

#Preview("Stat Card - Without Icon", traits: .sizeThatFitsLayout) {
    HStack(spacing: InkuSpacing.spacing12) {
        InkuStatCard(
            value: "1997",
            label: "Started"
        )

        InkuStatCard(
            value: "Present",
            label: "Ended"
        )

        InkuStatCard(
            value: "26+",
            label: "Years"
        )
    }
    .padding()
    .background(Color.inkuSurface)
}

#Preview("Stat Card - Grid Layout", traits: .sizeThatFitsLayout) {
    VStack(spacing: InkuSpacing.spacing12) {
        HStack(spacing: InkuSpacing.spacing12) {
            InkuStatCard(
                icon: "star.fill",
                value: "9.21",
                label: "Score",
                accentColor: .yellow
            )

            InkuStatCard(
                icon: "book.fill",
                value: "Unknown",
                label: "Volumes",
                accentColor: .blue
            )
        }

        HStack(spacing: InkuSpacing.spacing12) {
            InkuStatCard(
                icon: "doc.text.fill",
                value: "Unknown",
                label: "Chapters",
                accentColor: .green
            )

            InkuStatCard(
                icon: "checkmark.circle.fill",
                value: "Publishing",
                label: "Status"
            )
        }
    }
    .padding()
    .background(Color.inkuSurface)
}

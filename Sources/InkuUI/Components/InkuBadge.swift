//
//  InkuBadge.swift
//  InkuUI
//
//  Created by Eduardo Andrade on 25/12/25.
//

import SwiftUI

/// A compact badge component for displaying category labels, tags, or status indicators
///
/// InkuBadge provides three visual styles (accent, secondary, outlined) and supports
/// skeleton loading state to display placeholders during data fetching.
///
/// Example usage:
/// ```swift
/// InkuBadge(text: "Shounen", style: .accent)
/// InkuBadge(text: "Ongoing", style: .secondary)
/// InkuBadge(text: "New", style: .outlined)
/// InkuBadge(text: "Loading...", isLoading: true)
/// ```
public struct InkuBadge: View {

    public enum Style {
        case accent
        case secondary
        case outlined
    }

    public enum Size {
        case standard
        case large

        var font: Font {
            switch self {
            case .standard:
                return .inkuCaptionSmall
            case .large:
                return .inkuBody
            }
        }

        var horizontalPadding: CGFloat {
            switch self {
            case .standard:
                return InkuSpacing.spacing8
            case .large:
                return InkuSpacing.spacing12
            }
        }

        var verticalPadding: CGFloat {
            switch self {
            case .standard:
                return InkuSpacing.spacing4
            case .large:
                return InkuSpacing.spacing12
            }
        }
    }

    // MARK: - Properties

    let text: String
    var style: Style
    var size: Size
    let isLoading: Bool

    // MARK: - Initializers

    public init(text: String, style: Style = .accent, size: Size = .standard, isLoading: Bool = false) {
        self.text = text
        self.style = style
        self.size = size
        self.isLoading = isLoading
    }

    // MARK: - Body

    public var body: some View {
        Text(text)
            .font(size.font)
            .fontWeight(.medium)
            .inkuSkeleton(isLoading)
            .padding(.horizontal, size.horizontalPadding)
            .padding(.vertical, size.verticalPadding)
            .foregroundStyle(foregroundColor)
            .background(backgroundColor)
            .clipShape(Capsule())
            .overlay {
                if style == .outlined && !isLoading {
                    Capsule()
                        .stroke(Color.inkuAccent, lineWidth: 1)
                }
            }
    }

    // MARK: - Private Properties

    private var foregroundColor: Color {
        switch style {
        case .accent:
            return .inkuTextOnAccent
        case .secondary:
            return .inkuTextSecondary
        case .outlined:
            return .inkuAccent
        }
    }

    private var backgroundColor: Color {
        if isLoading {
            return .inkuSurfaceSecondary
        }

        switch style {
        case .accent:
            return .inkuAccent
        case .secondary:
            return .inkuSurfaceSecondary
        case .outlined:
            return .clear
        }
    }
}

// MARK: - Previews

#Preview("Badge Styles", traits: .sizeThatFitsLayout) {
    VStack(spacing: InkuSpacing.spacing16) {
        Text("Standard Size")
            .font(.caption)
            .foregroundStyle(.secondary)

        HStack(spacing: InkuSpacing.spacing12) {
            InkuBadge(text: "Shounen", style: .accent)
            InkuBadge(text: "Ongoing", style: .secondary)
            InkuBadge(text: "New", style: .outlined)
        }

        Text("Large Size (44pt touch target)")
            .font(.caption)
            .foregroundStyle(.secondary)
            .padding(.top)

        HStack(spacing: InkuSpacing.spacing12) {
            InkuBadge(text: "Action", style: .accent, size: .large)
            InkuBadge(text: "Adventure", style: .secondary, size: .large)
            InkuBadge(text: "Comedy", style: .outlined, size: .large)
        }

        Text("Loading States")
            .font(.caption)
            .foregroundStyle(.secondary)
            .padding(.top)

        HStack(spacing: InkuSpacing.spacing12) {
            InkuBadge(text: "Loading", style: .accent, isLoading: true)
            InkuBadge(text: "Loading", style: .secondary, isLoading: true)
            InkuBadge(text: "Loading", style: .outlined, isLoading: true)
        }
    }
    .padding()
    .background(Color.inkuSurface)
}

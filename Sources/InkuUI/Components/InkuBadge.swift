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

    // MARK: - Properties

    let text: String
    var style: Style
    let isLoading: Bool

    // MARK: - Initializers

    public init(text: String, style: Style = .accent, isLoading: Bool = false) {
        self.text = text
        self.style = style
        self.isLoading = isLoading
    }

    // MARK: - Body

    public var body: some View {
        Text(text)
            .font(.inkuCaptionSmall)
            .fontWeight(.medium)
            .inkuSkeleton(isLoading)
            .padding(.horizontal, InkuSpacing.spacing8)
            .padding(.vertical, InkuSpacing.spacing4)
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
        HStack(spacing: InkuSpacing.spacing12) {
            InkuBadge(text: "Shounen", style: .accent)
            InkuBadge(text: "Ongoing", style: .secondary)
            InkuBadge(text: "New", style: .outlined)
        }

        HStack(spacing: InkuSpacing.spacing12) {
            InkuBadge(text: "Loading", style: .accent, isLoading: true)
            InkuBadge(text: "Loading", style: .secondary, isLoading: true)
            InkuBadge(text: "Loading", style: .outlined, isLoading: true)
        }
    }
    .padding()
    .background(Color.inkuSurface)
}

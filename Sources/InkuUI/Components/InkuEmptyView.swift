//
//  InkuEmptyView.swift
//  InkuUI
//
//  Created by Eduardo Andrade on 25/12/25.
//

import SwiftUI

/// An empty state component for displaying when no content is available
///
/// InkuEmptyView shows a centered message with icon, title, optional subtitle,
/// and optional action button to guide users toward content creation or discovery.
///
/// Example usage:
/// ```swift
/// InkuEmptyView(title: "No manga found")
/// InkuEmptyView(icon: "book", title: "Library is empty", subtitle: "Start adding manga")
/// InkuEmptyView(icon: "magnifyingglass", iconSize: .large, title: "Search for Manga")
/// ```
public struct InkuEmptyView: View {

    // MARK: - Types

    public enum IconSize {
        case small
        case medium
        case large

        var font: Font {
            switch self {
            case .small: return .inkuIconSmall
            case .medium: return .inkuIconMedium
            case .large: return .inkuIconLarge
            }
        }
    }

    public enum SymbolEffect {
        case pulse
        case bounce
        case variableColor
        case scale
    }

    // MARK: - Properties

    let icon: String
    let iconSize: IconSize
    let title: String
    var subtitle: String?
    var actionTitle: String?
    var action: (() -> Void)?
    var symbolEffect: SymbolEffect?
    var symbolEffectOptions: SymbolEffectOptions?

    // MARK: - Initializers

    public init(
        icon: String = "tray",
        iconSize: IconSize = .medium,
        title: String,
        subtitle: String? = nil,
        actionTitle: String? = nil,
        symbolEffect: SymbolEffect? = nil,
        symbolEffectOptions: SymbolEffectOptions? = nil,
        action: (() -> Void)? = nil
    ) {
        self.icon = icon
        self.iconSize = iconSize
        self.title = title
        self.subtitle = subtitle
        self.actionTitle = actionTitle
        self.symbolEffect = symbolEffect
        self.symbolEffectOptions = symbolEffectOptions
        self.action = action
    }

    // MARK: - Body

    public var body: some View {
        VStack(spacing: InkuSpacing.spacing16) {
            iconView

            VStack(spacing: InkuSpacing.spacing8) {
                Text(title)
                    .font(.inkuHeadline)
                    .foregroundStyle(Color.inkuText)

                if let subtitle {
                    Text(subtitle)
                        .font(.inkuBodySmall)
                        .foregroundStyle(Color.inkuTextSecondary)
                        .multilineTextAlignment(.center)
                }
            }

            if let action, let actionTitle {
                InkuButton(actionTitle, style: .secondary, action: action)
            }
        }
        .padding(InkuSpacing.spacing24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    // MARK: - Private Views

    @ViewBuilder
    private var iconView: some View {
        let image = Image(systemName: icon)
            .font(iconSize.font)
            .foregroundStyle(Color.inkuAccent)

        if let effect = symbolEffect {
            let options = symbolEffectOptions ?? .default
            switch effect {
            case .pulse:
                image.symbolEffect(.pulse, options: options)
            case .bounce:
                image.symbolEffect(.bounce, options: options)
            case .variableColor:
                image.symbolEffect(.variableColor, options: options)
            case .scale:
                image.symbolEffect(.scale, options: options)
            }
        } else {
            image
        }
    }
}

// MARK: - Previews

#Preview("Basic Empty View") {
    InkuEmptyView(
        icon: "book.closed",
        title: "No manga found",
        subtitle: "Try adjusting your filters"
    )
    .frame(height: 400)
    .background(Color.inkuSurface)
}

#Preview("With Action Button") {
    InkuEmptyView(
        icon: "heart",
        title: "No favorites yet",
        subtitle: "Start adding manga to your favorites",
        actionTitle: "Browse Manga"
    ) {
        print("Browse tapped")
    }
    .frame(height: 400)
    .background(Color.inkuSurface)
}

#Preview("Symbol Effects") {
    ScrollView {
        VStack(spacing: 40) {
            VStack(spacing: 8) {
                Text("Pulse Effect (Repeating)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                InkuEmptyView(
                    icon: "magnifyingglass",
                    iconSize: .large,
                    title: "Search for Manga",
                    subtitle: "Start typing to find your favorites",
                    symbolEffect: .pulse,
                    symbolEffectOptions: .repeating
                )
            }

            VStack(spacing: 8) {
                Text("Bounce Effect (Repeating)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                InkuEmptyView(
                    icon: "doc.text.magnifyingglass",
                    iconSize: .large,
                    title: "No Results",
                    subtitle: "Try different keywords",
                    symbolEffect: .bounce,
                    symbolEffectOptions: .repeating
                )
            }

            VStack(spacing: 8) {
                Text("Variable Color Effect")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                InkuEmptyView(
                    icon: "arrow.down.circle",
                    iconSize: .medium,
                    title: "Loading...",
                    subtitle: "Please wait",
                    symbolEffect: .variableColor,
                    symbolEffectOptions: .repeating
                )
            }

            VStack(spacing: 8) {
                Text("Scale Effect")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                InkuEmptyView(
                    icon: "wifi.slash",
                    iconSize: .medium,
                    title: "Connection Lost",
                    subtitle: "Check your internet connection",
                    symbolEffect: .scale,
                    symbolEffectOptions: .repeat(3)
                )
            }
        }
        .padding()
    }
    .background(Color.inkuSurface)
}

#Preview("Icon Sizes") {
    ScrollView {
        VStack(spacing: 40) {
            InkuEmptyView(
                icon: "star",
                iconSize: .small,
                title: "Small Icon",
                subtitle: "Uses inkuIconSmall typography"
            )

            InkuEmptyView(
                icon: "star",
                iconSize: .medium,
                title: "Medium Icon",
                subtitle: "Uses inkuIconMedium typography"
            )

            InkuEmptyView(
                icon: "star",
                iconSize: .large,
                title: "Large Icon",
                subtitle: "Uses inkuIconLarge typography"
            )
        }
        .padding()
    }
    .background(Color.inkuSurface)
}

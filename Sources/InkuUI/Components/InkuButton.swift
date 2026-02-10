//
//  InkuButton.swift
//  InkuUI
//
//  Created by Eduardo Andrade on 25/12/25.
//

import SwiftUI

/// A customizable button component with multiple visual styles and enhanced features
///
/// InkuButton provides primary, secondary, ghost, and outlined styles with consistent sizing,
/// spacing, and interaction feedback. Supports loading states, disabled states, badges, and fixed heights.
///
/// Example usage:
/// ```swift
/// InkuButton("Continue", style: .primary) { /* action */ }
/// InkuButton("Cancel", style: .secondary) { /* action */ }
/// InkuButton("Skip", icon: "arrow.right", style: .ghost) { /* action */ }
/// InkuButton("Sign In", style: .primary, isFullWidth: true) { /* action */ }
/// InkuButton("Loading...", isLoading: true, loadingText: "Signing in...") { /* action */ }
/// InkuButton("Search", badge: "5", style: .outlined) { /* action */ }
/// InkuButton("Disabled", isDisabled: true) { /* action */ }
/// ```
public struct InkuButton: View {

    public enum Style {
        case primary
        case secondary
        case ghost
        case outlined
    }

    // MARK: - Properties

    let title: String
    var icon: String?
    var style: Style
    var isFullWidth: Bool
    var isLoading: Bool
    var loadingText: String?
    var isDisabled: Bool
    var badge: String?
    var height: CGFloat?
    var backgroundColorOverride: Color?
    var cornerRadiusOverride: CGFloat?
    let action: () -> Void

    // MARK: - Initializers

    public init(
        _ title: String,
        icon: String? = nil,
        style: Style = .primary,
        isFullWidth: Bool = false,
        isLoading: Bool = false,
        loadingText: String? = nil,
        isDisabled: Bool = false,
        badge: String? = nil,
        height: CGFloat? = nil,
        backgroundColor: Color? = nil,
        cornerRadius: CGFloat? = nil,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.style = style
        self.isFullWidth = isFullWidth
        self.isLoading = isLoading
        self.loadingText = loadingText
        self.isDisabled = isDisabled
        self.badge = badge
        self.height = height
        self.backgroundColorOverride = backgroundColor
        self.cornerRadiusOverride = cornerRadius
        self.action = action
    }

    // MARK: - Body

    public var body: some View {
        Button(action: action) {
            HStack(spacing: InkuSpacing.spacing8) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .controlSize(.small)
                        #if os(iOS)
                        .tint(foregroundColor)
                        #endif
                }

                if let icon, !isLoading {
                    Image(systemName: icon)
                }

                HStack(spacing: InkuSpacing.spacing4) {
                    Text(isLoading && loadingText != nil ? loadingText! : title)

                    if let badge, !isLoading {
                        Text("(\(badge))")
                            .foregroundStyle(badgeForegroundColor)
                    }
                }
            }
            .font(.inkuBody)
            .fontWeight(.semibold)
            .padding(.horizontal, InkuSpacing.spacing16)
            .padding(.vertical, height != nil ? 0 : InkuSpacing.spacing12)
            .frame(maxWidth: isFullWidth ? .infinity : nil)
            .frame(height: height)
            .foregroundStyle(foregroundColor)
            .background(computedBackgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadiusOverride ?? InkuRadius.radius8))
            .overlay {
                if style == .outlined {
                    RoundedRectangle(cornerRadius: cornerRadiusOverride ?? InkuRadius.radius8)
                        .stroke(outlineColor, lineWidth: 2)
                }
            }
            .opacity(isDisabled ? 0.6 : 1.0)
        }
        .disabled(isDisabled || isLoading)
        #if !os(iOS)
        .buttonStyle(.borderless)
        #endif
        #if os(visionOS)
        .hoverEffectDisabled()
        .scaleHoverEffect(value: 1.04)
        #endif
    }

    // MARK: - Private Properties

    private var foregroundColor: Color {
        switch style {
        case .primary:
            return .inkuTextOnAccent
        case .secondary:
            return .inkuAccentStrong
        case .ghost, .outlined:
            return .inkuAccent
        }
    }

    private var backgroundColor: Color {
        switch style {
        case .primary:
            return .inkuAccent
        case .secondary:
            return .inkuAccentSubtle
        case .ghost, .outlined:
            return .clear
        }
    }

    private var computedBackgroundColor: Color {
        if let override = backgroundColorOverride {
            return override
        }
        return backgroundColor
    }

    private var outlineColor: Color {
        return isDisabled ? .inkuTextTertiary : .inkuAccent
    }

    private var badgeBackgroundColor: Color {
        switch style {
        case .primary:
            return .inkuTextOnAccent.opacity(0.2)
        case .secondary, .ghost, .outlined:
            return .inkuAccent.opacity(0.15)
        }
    }

    private var badgeForegroundColor: Color {
        switch style {
        case .primary:
            return .inkuTextOnAccent
        case .secondary, .ghost, .outlined:
            return .inkuAccentStrong
        }
    }
}

// MARK: - Previews

#Preview("Button Styles", traits: .sizeThatFitsLayout) {
    VStack(spacing: InkuSpacing.spacing12) {
        InkuButton("Primary", style: .primary) { }
        InkuButton("Secondary", icon: "heart", style: .secondary) { }
        InkuButton("Ghost", style: .ghost) { }
        InkuButton("Outlined", style: .outlined) { }
        InkuButton("Full Width", style: .primary, isFullWidth: true) { }
    }
    .padding()
    .background(Color.inkuSurface)
}

#Preview("Button States", traits: .sizeThatFitsLayout) {
    VStack(spacing: InkuSpacing.spacing12) {
        InkuButton("Loading", isLoading: true, loadingText: "Please wait...") { }
        InkuButton("Disabled", isDisabled: true) { }
        InkuButton("With Badge", style: .primary, badge: "5") { }
        InkuButton("Fixed Height", style: .primary, isFullWidth: true, height: 50) { }
        InkuButton("Custom Color", backgroundColor: .mint) { }
        InkuButton("Custom Radius", cornerRadius: InkuRadius.radius16) { }
    }
    .padding()
    .background(Color.inkuSurface)
}

#Preview("Authentication Example", traits: .sizeThatFitsLayout) {
    VStack(spacing: InkuSpacing.spacing16) {
        InkuButton(
            "Sign In",
            style: .primary,
            isFullWidth: true,
            height: 50,
            cornerRadius: InkuRadius.radius12
        ) { }

        InkuButton(
            "Signing in...",
            style: .primary,
            isFullWidth: true,
            isLoading: true,
            height: 50,
            cornerRadius: InkuRadius.radius12
        ) { }

        InkuButton(
            "Sign In Disabled",
            style: .primary,
            isFullWidth: true,
            isDisabled: true,
            height: 50,
            backgroundColor: .inkuTextTertiary,
            cornerRadius: InkuRadius.radius12
        ) { }
    }
    .padding()
    .background(Color.inkuSurface)
}

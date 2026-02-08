//
//  InkuButton.swift
//  InkuUI
//
//  Created by Eduardo Andrade on 25/12/25.
//

import SwiftUI

/// A customizable button component with three visual styles and optional icon support
///
/// InkuButton provides primary, secondary, and ghost styles with consistent sizing,
/// spacing, and interaction feedback. Supports both compact and full-width layouts.
///
/// Example usage:
/// ```swift
/// InkuButton("Continue", style: .primary) { /* action */ }
/// InkuButton("Cancel", style: .secondary) { /* action */ }
/// InkuButton("Skip", icon: "arrow.right", style: .ghost) { /* action */ }
/// InkuButton("Sign In", style: .primary, isFullWidth: true) { /* action */ }
/// ```
public struct InkuButton: View {

    public enum Style {
        case primary
        case secondary
        case ghost
    }

    // MARK: - Properties

    let title: String
    var icon: String?
    var style: Style
    var isFullWidth: Bool
    let action: () -> Void

    // MARK: - Initializers

    public init(
        _ title: String,
        icon: String? = nil,
        style: Style = .primary,
        isFullWidth: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.style = style
        self.isFullWidth = isFullWidth
        self.action = action
    }

    // MARK: - Body

    public var body: some View {
        Button(action: action) {
            HStack(spacing: InkuSpacing.spacing8) {
                if let icon {
                    Image(systemName: icon)
                }
                Text(title)
            }
            .font(.inkuHeadline)
            .padding(.horizontal, InkuSpacing.spacing16)
            .padding(.vertical, InkuSpacing.spacing12)
            .frame(maxWidth: isFullWidth ? .infinity : nil)
            .foregroundStyle(foregroundColor)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: InkuRadius.radius8))
        }
        #if !os(iOS)
        .buttonStyle(.borderless)
        #endif
    }

    // MARK: - Private Properties

    private var foregroundColor: Color {
        switch style {
        case .primary:
            return .inkuTextOnAccent
        case .secondary:
            return .inkuAccentStrong
        case .ghost:
            return .inkuAccent
        }
    }

    private var backgroundColor: Color {
        switch style {
        case .primary:
            return .inkuAccent
        case .secondary:
            return .inkuAccentSubtle
        case .ghost:
            return .clear
        }
    }
}

// MARK: - Previews

#Preview("Button Styles", traits: .sizeThatFitsLayout) {
    VStack(spacing: InkuSpacing.spacing12) {
        InkuButton("Primary", style: .primary) { }
        InkuButton("Secondary", icon: "heart", style: .secondary) { }
        InkuButton("Ghost", style: .ghost) { }
        InkuButton("Full Width", style: .primary, isFullWidth: true) { }
    }
    .padding()
    .background(Color.inkuSurface)
}

//
//  InkuListContainer.swift
//  InkuUI
//
//  Created by Eduardo Andrade on 02/01/26.
//

import SwiftUI

/// A reusable container for list views with consistent Inku visual identity
///
/// InkuListContainer provides a standardized wrapper for list content with optional header,
/// consistent spacing, keyboard dismissal behavior, and Inku design tokens. Use this for
/// all list-based screens to maintain visual consistency.
///
/// Example usage:
/// ```swift
/// InkuListContainer(
///     title: "Search Results",
///     subtitle: "Found 42 manga",
///     scrollDismissesKeyboard: .interactively
/// ) {
///     LazyVStack(spacing: InkuSpacing.spacing16) {
///         ForEach(items) { item in
///             ItemRowView(item: item)
///         }
///     }
/// }
/// ```
public struct InkuListContainer<Content: View>: View {

    // MARK: - Properties

    let title: String?
    let subtitle: String?
    let showsDivider: Bool
    let contentPadding: CGFloat
    let scrollDisabled: Bool
    let content: Content

    // MARK: - Initializers

    public init(
        title: String? = nil,
        subtitle: String? = nil,
        showsDivider: Bool = true,
        contentPadding: CGFloat = InkuSpacing.spacing16,
        scrollDisabled: Bool = false,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.subtitle = subtitle
        self.showsDivider = showsDivider
        self.contentPadding = contentPadding
        self.scrollDisabled = scrollDisabled
        self.content = content()
    }

    #if !os(visionOS)
    public init(
        title: String? = nil,
        subtitle: String? = nil,
        showsDivider: Bool = true,
        contentPadding: CGFloat = InkuSpacing.spacing16,
        scrollDisabled: Bool = false,
        scrollDismissesKeyboard: ScrollDismissesKeyboardMode,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.subtitle = subtitle
        self.showsDivider = showsDivider
        self.contentPadding = contentPadding
        self.scrollDisabled = scrollDisabled
        self.scrollDismissesKeyboard = scrollDismissesKeyboard
        self.content = content()
    }
    #endif

    // MARK: - Body

    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // Header section
                if title != nil || subtitle != nil {
                    headerView
                        .padding(.horizontal, contentPadding)
                        .padding(.top, InkuSpacing.spacing20)
                        .padding(.bottom, InkuSpacing.spacing12)

                    if showsDivider {
                        Divider()
                            .background(Color.inkuTextTertiary.opacity(0.2))
                            .padding(.bottom, InkuSpacing.spacing16)
                    }
                }

                // Content
                content
                    .padding(.horizontal, contentPadding)
                    .padding(.bottom, contentPadding)
            }
        }
        .scrollDisabled(scrollDisabled)
        #if !os(visionOS)
        .scrollDismissesKeyboard(scrollDismissesKeyboard)
        #endif
        .background(Color.inkuSurface)
    }

    // MARK: - Private Properties

    #if !os(visionOS)
    private var scrollDismissesKeyboard: ScrollDismissesKeyboardMode = .automatic
    #endif

    // MARK: - Private Views

    @ViewBuilder
    private var headerView: some View {
        VStack(alignment: .leading, spacing: InkuSpacing.spacing4) {
            if let title {
                Text(title)
                    .font(.inkuDisplayMedium)
                    .foregroundStyle(Color.inkuText)
            }

            if let subtitle {
                Text(subtitle)
                    .font(.inkuBodySmall)
                    .foregroundStyle(Color.inkuTextSecondary)
            }
        }
    }
}

// MARK: - Previews

#Preview("Basic List Container") {
    InkuListContainer(
        title: "Popular Manga",
        subtitle: "Top rated this week"
    ) {
        LazyVStack(spacing: InkuSpacing.spacing16) {
            ForEach(0..<5) { index in
                RoundedRectangle(cornerRadius: InkuRadius.radius12)
                    .fill(Color.inkuSurfaceElevated)
                    .frame(height: 120)
                    .overlay {
                        Text("Item \(index + 1)")
                            .font(.inkuHeadline)
                            .foregroundStyle(Color.inkuText)
                    }
            }
        }
    }
}

#Preview("Without Header") {
    InkuListContainer {
        LazyVStack(spacing: InkuSpacing.spacing16) {
            ForEach(0..<8) { index in
                RoundedRectangle(cornerRadius: InkuRadius.radius12)
                    .fill(Color.inkuSurfaceElevated)
                    .frame(height: 80)
                    .overlay {
                        Text("Item \(index + 1)")
                            .font(.inkuBodySmall)
                            .foregroundStyle(Color.inkuText)
                    }
            }
        }
    }
}

#Preview("With Title Only") {
    InkuListContainer(
        title: "Search Results",
        showsDivider: false
    ) {
        LazyVStack(spacing: InkuSpacing.spacing12) {
            ForEach(0..<10) { index in
                HStack {
                    Circle()
                        .fill(Color.inkuAccent)
                        .frame(width: 40, height: 40)
                    Text("Result \(index + 1)")
                        .font(.inkuBody)
                        .foregroundStyle(Color.inkuText)
                    Spacer()
                }
                .padding(InkuSpacing.spacing12)
                .inkuCard()
            }
        }
    }
}

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
/// InkuEmptyView(title: "No results", actionTitle: "Clear filters") { /* action */ }
/// ```
public struct InkuEmptyView: View {

    // MARK: - Properties

    let icon: String
    let title: String
    var subtitle: String?
    var actionTitle: String?
    var action: (() -> Void)?

    // MARK: - Initializers

    public init(
        icon: String = "tray",
        title: String,
        subtitle: String? = nil,
        actionTitle: String? = nil,
        action: (() -> Void)? = nil
    ) {
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
        self.actionTitle = actionTitle
        self.action = action
    }

    // MARK: - Body

    public var body: some View {
        VStack(spacing: InkuSpacing.spacing16) {
            Image(systemName: icon)
                .font(.system(size: 48))
                .foregroundStyle(Color.inkuTextTertiary)

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
}

// MARK: - Previews

#Preview("Empty View", traits: .sizeThatFitsLayout) {
    VStack {
        InkuEmptyView(
            icon: "book.closed",
            title: "No manga found",
            subtitle: "Try adjusting your filters"
        )
        .frame(height: 300)

        InkuEmptyView(
            icon: "heart",
            title: "No favorites yet",
            subtitle: "Start adding manga to your favorites",
            actionTitle: "Browse Manga"
        ) {
            print("Browse tapped")
        }
        .frame(height: 300)
    }
    .background(Color.inkuSurface)
}

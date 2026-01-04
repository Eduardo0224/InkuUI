//
//  InkuAuthorResultCard.swift
//  InkuUI
//
//  Created by Eduardo Andrade on 03/01/26.
//

import SwiftUI

/// A specialized card component for displaying author search results
///
/// InkuAuthorResultCard is optimized for displaying author information in search results,
/// showing the author's full name and role. Unlike manga cards which display cover images,
/// this component focuses on text-based information with iconography.
///
/// Example usage:
/// ```swift
/// InkuAuthorResultCard(
///     firstName: "Eiichiro",
///     lastName: "Oda",
///     role: "Story & Art"
/// )
/// ```
public struct InkuAuthorResultCard: View {

    // MARK: - Properties

    let firstName: String
    let lastName: String
    let role: String
    let isLoading: Bool

    // MARK: - Computed Properties

    private var fullName: String {
        "\(firstName) \(lastName)"
    }

    private var initials: String {
        let first = firstName.prefix(1)
        let last = lastName.prefix(1)
        return "\(first)\(last)".uppercased()
    }

    // MARK: - Initializers

    public init(
        firstName: String,
        lastName: String,
        role: String,
        isLoading: Bool = false
    ) {
        self.firstName = firstName
        self.lastName = lastName
        self.role = role
        self.isLoading = isLoading
    }

    // MARK: - Body

    public var body: some View {
        HStack(spacing: InkuSpacing.spacing12) {
            // Initials circle
            initialsView
                .inkuSkeleton(isLoading)

            // Author info
            VStack(alignment: .leading, spacing: InkuSpacing.spacing4) {
                Text(fullName)
                    .font(.inkuHeadline)
                    .foregroundStyle(Color.inkuText)
                    .lineLimit(1)
                    .inkuSkeleton(isLoading)

                InkuBadge(text: role, style: .outlined)
                    .inkuSkeleton(isLoading)
                    .lineLimit(1)
            }

            Spacer()

            // Arrow indicator
            Image(systemName: "chevron.right")
                .font(.inkuCaption)
                .foregroundStyle(Color.inkuTextTertiary)
                .inkuSkeleton(isLoading)
        }
        .padding(InkuSpacing.spacing12)
        .background(Color.inkuSurfaceElevated)
        .clipShape(RoundedRectangle(cornerRadius: InkuRadius.radius12))
        .shadow(color: .black.opacity(0.05), radius: InkuRadius.radius4, y: 2)
    }

    // MARK: - Private Views

    private var initialsView: some View {
        ZStack {
            Circle()
                .fill(Color.inkuAccentSoft)
                .frame(width: 48, height: 48)

            Text(initials)
                .font(.inkuHeadline)
                .foregroundStyle(Color.inkuTextOnAccent)
        }
    }
}

// MARK: - Previews

#Preview("Author Card - Full Data") {
    InkuAuthorResultCard(
        firstName: "Eiichiro",
        lastName: "Oda",
        role: "Story & Art"
    )
    .padding()
    .background(Color.inkuSurface)
}

#Preview("Author Card - Loading") {
    InkuAuthorResultCard(
        firstName: "Loading",
        lastName: "Author",
        role: "Role",
        isLoading: true
    )
    .padding()
    .background(Color.inkuSurface)
}

#Preview("Author Card - Multiple Roles") {
    VStack(spacing: InkuSpacing.spacing12) {
        InkuAuthorResultCard(
            firstName: "Eiichiro",
            lastName: "Oda",
            role: "Story & Art"
        )

        InkuAuthorResultCard(
            firstName: "Kentaro",
            lastName: "Miura",
            role: "Story"
        )

        InkuAuthorResultCard(
            firstName: "Yusuke",
            lastName: "Murata",
            role: "Art"
        )
    }
    .padding()
    .background(Color.inkuSurface)
}

#Preview("Author Card List") {
    ScrollView {
        LazyVStack(spacing: InkuSpacing.spacing12) {
            ForEach(0..<5) { index in
                InkuAuthorResultCard(
                    firstName: "Author",
                    lastName: "Name \(index + 1)",
                    role: ["Story & Art", "Story", "Art"][index % 3],
                    isLoading: index < 2
                )
            }
        }
        .padding()
    }
    .background(Color.inkuSurface)
}

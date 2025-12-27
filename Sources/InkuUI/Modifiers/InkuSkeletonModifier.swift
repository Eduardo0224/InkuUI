//
//  InkuSkeletonModifier.swift
//  InkuUI
//
//  Created by Eduardo Andrade on 25/12/25.
//

import SwiftUI

/// Combines redacted placeholder with shimmer effect for skeleton loading
public struct InkuSkeletonModifier: ViewModifier {

    // MARK: - Properties

    var isLoading: Bool

    // MARK: - Initializers

    public init(isLoading: Bool = true) {
        self.isLoading = isLoading
    }

    // MARK: - Body

    public func body(content: Content) -> some View {
        if isLoading {
            content
                .redacted(reason: .placeholder)
                .shimmer()
                .disabled(true)
        } else {
            content
        }
    }
}

public extension View {

    /// Apply skeleton loading effect with redacted placeholder and shimmer
    /// - Parameter isLoading: Whether the loading state is active
    /// - Returns: View with skeleton loading effect when loading
    func inkuSkeleton(_ isLoading: Bool = true) -> some View {
        modifier(InkuSkeletonModifier(isLoading: isLoading))
    }
}

// MARK: - Previews

#Preview("Loading States", traits: .sizeThatFitsLayout) {
    VStack(spacing: InkuSpacing.spacing24) {
        // Loading state
        VStack(alignment: .leading, spacing: InkuSpacing.spacing8) {
            Text("Title Placeholder")
                .font(.inkuHeadline)
            Text("Subtitle Placeholder")
                .font(.inkuCaption)
            Text("Description placeholder that spans multiple lines of text")
                .font(.inkuBodySmall)
        }
        .inkuSkeleton(true)
        .padding()
        .inkuCard()

        // Loaded state
        VStack(alignment: .leading, spacing: InkuSpacing.spacing8) {
            Text("Actual Title")
                .font(.inkuHeadline)
            Text("Actual Subtitle")
                .font(.inkuCaption)
            Text("Actual description with real content")
                .font(.inkuBodySmall)
        }
        .inkuSkeleton(false)
        .padding()
        .inkuCard()
    }
    .padding()
    .background(Color.inkuSurface)
}

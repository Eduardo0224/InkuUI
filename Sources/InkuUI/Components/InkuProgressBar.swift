//
//  InkuProgressBar.swift
//  InkuUI
//
//  Created by Eduardo Andrade on 10/01/26.
//

import SwiftUI

/// A progress bar component for displaying completion status
///
/// InkuProgressBar shows a horizontal progress indicator with optional label and percentage.
/// The component is flexible and can be used to show reading progress, download status,
/// or any other completion metric.
///
/// Example usage:
/// ```swift
/// // With label and percentage
/// InkuProgressBar(
///     progress: 0.65,
///     label: "Reading Progress",
///     showPercentage: true
/// )
///
/// // Progress only
/// InkuProgressBar(progress: 0.45)
///
/// // With label, no percentage
/// InkuProgressBar(
///     progress: 0.85,
///     label: "Completion",
///     showPercentage: false
/// )
/// ```
public struct InkuProgressBar: View {

    // MARK: - Properties

    let progress: Double
    let label: String?
    let showPercentage: Bool

    // MARK: - Initializers

    /// Creates a progress bar with optional label and percentage display
    /// - Parameters:
    ///   - progress: Progress value from 0.0 to 1.0
    ///   - label: Optional descriptive label shown on the left
    ///   - showPercentage: Whether to show percentage value on the right (default: true)
    public init(
        progress: Double,
        label: String? = nil,
        showPercentage: Bool = true
    ) {
        self.progress = progress
        self.label = label
        self.showPercentage = showPercentage
    }

    // MARK: - Body

    public var body: some View {
        VStack(alignment: .leading, spacing: InkuSpacing.spacing4) {
            if label != nil || showPercentage {
                HStack {
                    if let label {
                        Text(label)
                            .font(.inkuCaptionSmall)
                            .foregroundStyle(Color.inkuTextTertiary)
                    }

                    Spacer()

                    if showPercentage {
                        Text("\(Int(progress * 100))%")
                            .font(.inkuCaptionSmall)
                            .foregroundStyle(Color.inkuTextTertiary)
                    }
                }
            }

            ProgressView(value: progress)
                .tint(.inkuAccent)
        }
    }
}

// MARK: - Previews

#Preview("Progress Bar - All Variants", traits: .sizeThatFitsLayout) {
    VStack(spacing: InkuSpacing.spacing16) {
        // With label and percentage
        InkuProgressBar(
            progress: 0.65,
            label: "Reading Progress",
            showPercentage: true
        )

        // Progress only
        InkuProgressBar(progress: 0.45)

        // With label, no percentage
        InkuProgressBar(
            progress: 0.85,
            label: "Completion",
            showPercentage: false
        )

        // Low progress
        InkuProgressBar(
            progress: 0.15,
            label: "Just Started"
        )

        // Complete
        InkuProgressBar(
            progress: 1.0,
            label: "Finished"
        )
    }
    .padding()
    .background(Color.inkuSurface)
}

#Preview("Progress Bar - In Card Context", traits: .sizeThatFitsLayout) {
    VStack(spacing: InkuSpacing.spacing12) {
        // Simulating a collection item card context
        VStack(alignment: .leading, spacing: InkuSpacing.spacing8) {
            Text("One Piece")
                .font(.inkuHeadline)
                .foregroundStyle(Color.inkuText)

            HStack(spacing: InkuSpacing.spacing8) {
                Label("42 volumes", systemImage: "books.vertical.fill")
                    .font(.inkuCaption)
                    .foregroundStyle(Color.inkuTextSecondary)
            }

            InkuProgressBar(
                progress: 0.72,
                label: "Progress"
            )
        }
        .padding(InkuSpacing.spacing12)
        .background(Color.inkuSurfaceElevated)
        .clipShape(RoundedRectangle(cornerRadius: InkuRadius.radius12))
    }
    .padding()
    .background(Color.inkuSurface)
}

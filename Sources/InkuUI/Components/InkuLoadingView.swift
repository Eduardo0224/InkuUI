//
//  InkuLoadingView.swift
//  InkuUI
//
//  Created by Eduardo Andrade on 25/12/25.
//

import SwiftUI

/// A centered loading indicator component with optional message
///
/// InkuLoadingView displays a large progress spinner with optional text message,
/// filling the available space. Use for full-screen or content area loading states.
///
/// Example usage:
/// ```swift
/// InkuLoadingView()
/// InkuLoadingView(message: "Loading manga...")
/// ```
public struct InkuLoadingView: View {

    // MARK: - Properties

    var message: String?

    // MARK: - Initializers

    public init(message: String? = nil) {
        self.message = message
    }

    // MARK: - Body

    public var body: some View {
        VStack(spacing: InkuSpacing.spacing16) {
            ProgressView()
                .controlSize(.large)

            if let message {
                Text(message)
                    .font(.inkuBodySmall)
                    .foregroundStyle(Color.inkuTextSecondary)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Previews

#Preview("Loading View", traits: .sizeThatFitsLayout) {
    VStack {
        InkuLoadingView()
            .frame(height: 200)

        InkuLoadingView(message: "Loading manga...")
            .frame(height: 200)
    }
    .background(Color.inkuSurface)
}

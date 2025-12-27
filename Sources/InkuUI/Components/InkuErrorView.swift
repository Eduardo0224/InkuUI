//
//  InkuErrorView.swift
//  InkuUI
//
//  Created by Eduardo Andrade on 25/12/25.
//

import SwiftUI

/// An error state component for displaying error messages with optional retry action
///
/// InkuErrorView shows a centered error message with warning icon and optional
/// "Try Again" button, built on top of InkuEmptyView for consistency.
///
/// Example usage:
/// ```swift
/// InkuErrorView(message: "Network error")
/// InkuErrorView(message: "Failed to load") { retryFetch() }
/// ```
public struct InkuErrorView: View {

    // MARK: - Properties

    let message: String
    let retryActionTitle: String?
    var retryAction: (() -> Void)?

    // MARK: - Initializers

    public init(
        message: String,
        retryActionTitle: String? = nil,
        retryAction: (() -> Void)? = nil
    ) {
        self.message = message
        self.retryActionTitle = retryActionTitle
        self.retryAction = retryAction
    }

    // MARK: - Body

    public var body: some View {
        InkuEmptyView(
            icon: "exclamationmark.triangle",
            title: message,
            actionTitle: retryActionTitle,
            action: retryAction
        )
    }
}

// MARK: - Previews

#Preview("Error View", traits: .sizeThatFitsLayout) {
    VStack {
        InkuErrorView(message: "Something went wrong")
            .frame(height: 300)

        InkuErrorView(message: "Failed to load manga", retryActionTitle: "Try Again") {
            print("Retry tapped")
        }
        .frame(height: 300)
    }
    .background(Color.inkuSurface)
}

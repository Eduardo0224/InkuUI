//
//  InkuGlassModifier.swift
//  InkuUI
//
//  Created by Eduardo Andrade on 25/12/25.
//

import SwiftUI

public struct InkuGlassModifier: ViewModifier {

    // MARK: - Properties

    var isEnabled: Bool
    var cornerRadius: CGFloat

    // MARK: - Initializers

    public init(isEnabled: Bool = true, cornerRadius: CGFloat = InkuRadius.radius16) {
        self.isEnabled = isEnabled
        self.cornerRadius = cornerRadius
    }

    // MARK: - Body

    public func body(content: Content) -> some View {
        if #available(iOS 26, *), isEnabled {
            content
                .background(.ultraThinMaterial)
                .glassEffect(.regular)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        } else {
            content
                .background(Color.inkuSurfaceElevated.opacity(0.95))
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        }
    }
}

public extension View {

    /// Apply Liquid Glass effect (iOS 26+)
    /// - Parameters:
    ///   - isEnabled: Only enable when over dynamic content
    ///   - cornerRadius: Corner radius for the glass container
    /// - Note: Use sparingly - only for floating buttons, overlays, toolbars
    func inkuGlass(isEnabled: Bool = true, cornerRadius: CGFloat = InkuRadius.radius16) -> some View {
        modifier(InkuGlassModifier(isEnabled: isEnabled, cornerRadius: cornerRadius))
    }
}

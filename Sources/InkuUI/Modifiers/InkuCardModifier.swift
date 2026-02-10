//
//  InkuCardModifier.swift
//  InkuUI
//
//  Created by Eduardo Andrade on 25/12/25.
//

import SwiftUI

public struct InkuCardModifier: ViewModifier {

    // MARK: - Properties

    let cornerRadius: CGFloat
    let shadowRadius: CGFloat
    let hoverEffectIsEnabled: Bool

    // MARK: - Initializers

    public init(
        cornerRadius: CGFloat = InkuRadius.radius12,
        shadowRadius: CGFloat = InkuRadius.radius4,
        hoverEffectIsEnabled: Bool = false
    ) {
        self.cornerRadius = cornerRadius
        self.shadowRadius = shadowRadius
        self.hoverEffectIsEnabled = hoverEffectIsEnabled
    }

    // MARK: - Body

    public func body(content: Content) -> some View {
        content
            .background(Color.inkuSurfaceElevated)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .shadow(color: .black.opacity(0.08), radius: shadowRadius, y: 2)
            #if os(visionOS)
            .scaleHoverEffect(isEnabled: hoverEffectIsEnabled)
            #endif
    }
}

public extension View {

    func inkuCard(
        cornerRadius: CGFloat = InkuRadius.radius12,
        shadowRadius: CGFloat = InkuRadius.radius4
    ) -> some View {
        modifier(
            InkuCardModifier(
                cornerRadius: cornerRadius,
                shadowRadius: shadowRadius
            )
        )
    }

    func inkuHoverCard(
        cornerRadius: CGFloat = InkuRadius.radius12,
        shadowRadius: CGFloat = InkuRadius.radius4
    ) -> some View {
        modifier(
            InkuCardModifier(
                cornerRadius: cornerRadius,
                shadowRadius: shadowRadius,
                hoverEffectIsEnabled: true
            )
        )
    }
}

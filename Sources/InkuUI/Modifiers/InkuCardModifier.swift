//
//  InkuCardModifier.swift
//  InkuUI
//
//  Created by Eduardo Andrade on 25/12/25.
//

import SwiftUI

public struct InkuCardModifier: ViewModifier {

    // MARK: - Properties

    var cornerRadius: CGFloat
    var shadowRadius: CGFloat

    // MARK: - Initializers

    public init(
        cornerRadius: CGFloat = InkuRadius.radius12,
        shadowRadius: CGFloat = InkuRadius.radius4
    ) {
        self.cornerRadius = cornerRadius
        self.shadowRadius = shadowRadius
    }

    // MARK: - Body

    public func body(content: Content) -> some View {
        content
            .background(Color.inkuSurfaceElevated)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .shadow(color: .black.opacity(0.08), radius: shadowRadius, y: 2)
    }
}

public extension View {

    func inkuCard(
        cornerRadius: CGFloat = InkuRadius.radius12,
        shadowRadius: CGFloat = InkuRadius.radius4
    ) -> some View {
        modifier(InkuCardModifier(cornerRadius: cornerRadius, shadowRadius: shadowRadius))
    }
}

//
//  ShimmerModifier.swift
//  InkuUI
//
//  Created by Eduardo Andrade on 25/12/25.
//

import SwiftUI

public struct ShimmerModifier: ViewModifier {

    // MARK: - States

    @State private var phase: CGFloat = -1

    // MARK: - Initializers

    public init() { }

    // MARK: - Body

    public func body(content: Content) -> some View {
        content
            .overlay {
                shimmerOverlay
                    .mask(content)
            }
    }

    // MARK: - Private Views

    private var shimmerOverlay: some View {
        GeometryReader { geometry in
            LinearGradient(
                colors: [
                    .clear,
                    .white.opacity(0.35),
                    .clear
                ],
                startPoint: .leading,
                endPoint: .trailing
            )
            .frame(width: geometry.size.width * 0.5)
            .offset(x: phase * geometry.size.width)
            .onAppear {
                withAnimation(
                    .linear(duration: 1.2)
                    .repeatForever(autoreverses: false)
                ) {
                    phase = 1.5
                }
            }
        }
        .clipped()
    }
}

public extension View {

    func shimmer() -> some View {
        modifier(ShimmerModifier())
    }
}

//
//  ScaleHoverEffect.swift
//  InkuUI
//
//  Created by Eduardo Andrade on 09/02/26.
//

import SwiftUI

#if os(visionOS)
public struct ScaleHoverEffect: CustomHoverEffect {

    private let scale: CGFloat

    public init(scale: CGFloat = 1.05) {
        self.scale = scale
    }

    public func body(content: Content) -> some CustomHoverEffect {
        content.hoverEffect { effect, isActive, _ in
            effect.animation(.easeOut) {
                $0.scaleEffect(isActive ? scale : 1)
            }
        }
    }
}

public extension View {

    func scaleHoverEffect(
        value: CGFloat = 1.05,
        isEnabled: Bool = true
    ) -> some View {
        self
            .hoverEffect(ScaleHoverEffect(scale: value), isEnabled: isEnabled)
    }
}
#endif

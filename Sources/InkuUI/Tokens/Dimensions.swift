//
//  Dimensions.swift
//  InkuUI
//
//  Created by Claude Code on 06/02/26.
//
//  Platform-aware dimension scaling for consistent sizing across iOS, macOS, and tvOS
//

import SwiftUI

/// Platform-aware dimensions with automatic tvOS scaling
///
/// tvOS uses 1.5x multiplier for better visibility at 10-foot viewing distance
public enum InkuDimensions {

    /// Scales a dimension value for the current platform
    /// - Parameter value: Base dimension value (for iOS/macOS)
    /// - Returns: Scaled value (1.5x on tvOS, 1x elsewhere)
    public static func scale(_ value: CGFloat) -> CGFloat {
        #if os(tvOS)
        value * 1.5
        #else
        value
        #endif
    }

    /// Creates a scaled size for the current platform
    /// - Parameters:
    ///   - width: Base width
    ///   - height: Base height
    /// - Returns: Scaled CGSize
    public static func size(width: CGFloat, height: CGFloat) -> CGSize {
        .init(width: scale(width), height: scale(height))
    }

    // MARK: - Common Dimensions

    /// Small icon/avatar size (40pt → 60pt on tvOS)
    public static let iconSmall: CGFloat = scale(40)

    /// Medium icon/avatar size (48pt → 72pt on tvOS)
    public static let iconMedium: CGFloat = scale(48)

    /// Large icon/avatar size (64pt → 96pt on tvOS)
    public static let iconLarge: CGFloat = scale(64)

    /// Cover thumbnail width (80pt → 120pt on tvOS)
    public static let coverThumbnailWidth: CGFloat = scale(80)

    /// Cover thumbnail height (120pt → 180pt on tvOS)
    public static let coverThumbnailHeight: CGFloat = scale(120)

    /// Cover small width (160pt → 240pt on tvOS)
    public static let coverSmallWidth: CGFloat = scale(160)

    /// Cover small height (240pt → 360pt on tvOS)
    public static let coverSmallHeight: CGFloat = scale(240)

    /// Separator/divider width (6pt → 9pt on tvOS)
    public static let separatorWidth: CGFloat = scale(6)
}

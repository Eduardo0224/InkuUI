//
//  Spacing.swift
//  InkuUI
//
//  Created by Eduardo Andrade on 25/12/25.
//

import SwiftUI

/// Spacing scale based on 8pt grid system
///
/// tvOS uses 1.5x multiplier for better visibility at viewing distance (10-foot UI)
public enum InkuSpacing {

    /// 2pt - Tight inline spacing (3pt on tvOS)
    public static let spacing2: CGFloat = {
        #if os(tvOS)
        3
        #else
        2
        #endif
    }()

    /// 4pt - Icon to text (6pt on tvOS)
    public static let spacing4: CGFloat = {
        #if os(tvOS)
        6
        #else
        4
        #endif
    }()

    /// 8pt - Related elements (12pt on tvOS)
    public static let spacing8: CGFloat = {
        #if os(tvOS)
        12
        #else
        8
        #endif
    }()

    /// 10pt - Medium spacing (15pt on tvOS)
    public static let spacing10: CGFloat = {
        #if os(tvOS)
        15
        #else
        10
        #endif
    }()

    /// 12pt - Grouped content (18pt on tvOS)
    public static let spacing12: CGFloat = {
        #if os(tvOS)
        18
        #else
        12
        #endif
    }()

    /// 16pt - Section padding (24pt on tvOS)
    public static let spacing16: CGFloat = {
        #if os(tvOS)
        24
        #else
        16
        #endif
    }()

    /// 20pt - Card internal padding (30pt on tvOS)
    public static let spacing20: CGFloat = {
        #if os(tvOS)
        30
        #else
        20
        #endif
    }()

    /// 24pt - Between cards (36pt on tvOS)
    public static let spacing24: CGFloat = {
        #if os(tvOS)
        36
        #else
        24
        #endif
    }()

    /// 32pt - Section gaps (48pt on tvOS)
    public static let spacing32: CGFloat = {
        #if os(tvOS)
        48
        #else
        32
        #endif
    }()

    /// 48pt - Major section breaks (72pt on tvOS)
    public static let spacing48: CGFloat = {
        #if os(tvOS)
        72
        #else
        48
        #endif
    }()
}

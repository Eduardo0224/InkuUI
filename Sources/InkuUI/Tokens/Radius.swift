//
//  Radius.swift
//  InkuUI
//
//  Created by Eduardo Andrade on 25/12/25.
//

import SwiftUI

/// Corner radius scale for consistent rounded corners
///
/// tvOS uses larger radius values for better visibility at viewing distance
public enum InkuRadius {

    /// 4pt - Small elements (badges) (6pt on tvOS)
    public static let radius4: CGFloat = {
        #if os(tvOS)
        6
        #else
        4
        #endif
    }()

    /// 8pt - Buttons, small cards (12pt on tvOS)
    public static let radius8: CGFloat = {
        #if os(tvOS)
        12
        #else
        8
        #endif
    }()

    /// 12pt - Cards, containers (18pt on tvOS)
    public static let radius12: CGFloat = {
        #if os(tvOS)
        18
        #else
        12
        #endif
    }()

    /// 16pt - Large cards (24pt on tvOS)
    public static let radius16: CGFloat = {
        #if os(tvOS)
        24
        #else
        16
        #endif
    }()

    /// 20pt - Sheets, modals (30pt on tvOS)
    public static let radius20: CGFloat = {
        #if os(tvOS)
        30
        #else
        20
        #endif
    }()

    /// Full round (capsule)
    public static let full: CGFloat = .infinity
}

//
//  Radius.swift
//  InkuUI
//
//  Created by Eduardo Andrade on 25/12/25.
//

import SwiftUI

/// Corner radius scale for consistent rounded corners
public enum InkuRadius {

    /// 4pt - Small elements (badges)
    public static let radius4: CGFloat = 4

    /// 8pt - Buttons, small cards
    public static let radius8: CGFloat = 8

    /// 12pt - Cards, containers
    public static let radius12: CGFloat = 12

    /// 16pt - Large cards
    public static let radius16: CGFloat = 16

    /// 20pt - Sheets, modals
    public static let radius20: CGFloat = 20

    /// Full round (capsule)
    public static let full: CGFloat = .infinity
}

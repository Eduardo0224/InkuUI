//
//  Colors.swift
//  InkuUI
//
//  Created by Eduardo Andrade on 25/12/25.
//

import SwiftUI
#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif

public extension Color {

    // MARK: - Accent Colors

    /// Primary accent (#FFD0B5 light / auto-adjusted dark)
    static let inkuAccent = Color(
        light: Color(red: 1.0, green: 0.816, blue: 0.71),
        dark: Color(red: 0.9, green: 0.7, blue: 0.6)
    )

    /// Stronger accent for emphasis (#E8A882 light / auto-adjusted dark)
    static let inkuAccentStrong = Color(
        light: Color(red: 0.91, green: 0.659, blue: 0.51),
        dark: Color(red: 0.82, green: 0.56, blue: 0.42)
    )

    /// Softer accent for secondary elements (#FFE4D4 light / auto-adjusted dark)
    static let inkuAccentSoft = Color(
        light: Color(red: 1.0, green: 0.894, blue: 0.831),
        dark: Color(red: 0.4, green: 0.35, blue: 0.3)
    )

    /// Subtle accent for backgrounds (#FFF5EF light / #3D3535 dark)
    static let inkuAccentSubtle = Color(
        light: Color(red: 1.0, green: 0.961, blue: 0.937),
        dark: Color(red: 0.239, green: 0.208, blue: 0.208)
    )

    // MARK: - Surface Colors

    /// Main background (#FAF9F7 light / #302D2D dark)
    static let inkuSurface = Color(
        light: Color(red: 0.98, green: 0.976, blue: 0.969),
        dark: Color(red: 0.188, green: 0.176, blue: 0.176)
    )

    /// Elevated surfaces, cards (#FFFFFF light / #3D3939 dark)
    static let inkuSurfaceElevated = Color(
        light: .white,
        dark: Color(red: 0.239, green: 0.224, blue: 0.224)
    )

    /// Nested elements, inputs (#F0EFED light / #4A4545 dark)
    static let inkuSurfaceSecondary = Color(
        light: Color(red: 0.941, green: 0.937, blue: 0.929),
        dark: Color(red: 0.29, green: 0.271, blue: 0.271)
    )

    // MARK: - Text Colors

    /// Primary text (#1A1A1A light / #FAFAFA dark)
    static let inkuText = Color(
        light: Color(red: 0.102, green: 0.102, blue: 0.102),
        dark: Color(red: 0.98, green: 0.98, blue: 0.98)
    )

    /// Secondary text (#6B6B6B light / #A8A8A8 dark)
    static let inkuTextSecondary = Color(
        light: Color(red: 0.42, green: 0.42, blue: 0.42),
        dark: Color(red: 0.659, green: 0.659, blue: 0.659)
    )

    /// Tertiary text, metadata (#9A9A9A light / #787878 dark)
    static let inkuTextTertiary = Color(
        light: Color(red: 0.604, green: 0.604, blue: 0.604),
        dark: Color(red: 0.471, green: 0.471, blue: 0.471)
    )

    /// Text on accent backgrounds (#1A1A1A)
    static let inkuTextOnAccent = Color(red: 0.102, green: 0.102, blue: 0.102)

    // MARK: - Semantic Colors

    /// Success state
    static let inkuSuccess = Color.green

    /// Warning state
    static let inkuWarning = Color.orange

    /// Error state
    static let inkuError = Color.red
}

// MARK: - Helper Extension

private extension Color {

    init(light: Color, dark: Color) {
        #if canImport(UIKit)
        self.init(uiColor: UIColor(light: UIColor(light), dark: UIColor(dark)))
        #elseif canImport(AppKit)
        self.init(nsColor: NSColor(light: NSColor(light), dark: NSColor(dark)))
        #endif
    }
}

#if canImport(UIKit)
private extension UIColor {

    convenience init(light: UIColor, dark: UIColor) {
        self.init { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return dark
            default:
                return light
            }
        }
    }
}
#elseif canImport(AppKit)
private extension NSColor {

    convenience init(light: NSColor, dark: NSColor) {
        self.init(name: nil) { appearance in
            switch appearance.name {
            case .darkAqua, .vibrantDark, .accessibilityHighContrastDarkAqua, .accessibilityHighContrastVibrantDark:
                return dark
            default:
                return light
            }
        }
    }
}
#endif

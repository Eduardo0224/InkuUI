//
//  PlatformImage.swift
//  InkuUI
//
//  Created by Claude Code on 06/02/26.
//
//  Cross-platform image type alias for iOS, macOS, and tvOS
//

#if canImport(UIKit)
import UIKit
public typealias PlatformImage = UIImage
#elseif canImport(AppKit)
import AppKit
public typealias PlatformImage = NSImage
#endif

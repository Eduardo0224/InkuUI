//
//  Typography.swift
//  InkuUI
//
//  Created by Eduardo Andrade on 25/12/25.
//

import SwiftUI

public extension Font {

    // MARK: - Display

    /// Hero titles, featured manga
    static let inkuDisplayLarge: Font = .largeTitle.bold()

    /// Section headers
    static let inkuDisplayMedium: Font = .title.bold()

    // MARK: - Headlines

    /// Card titles, manga names
    static let inkuHeadline: Font = .headline

    /// Subtitles
    static let inkuSubheadline: Font = .subheadline

    // MARK: - Body

    /// Main content
    static let inkuBody: Font = .body

    /// Secondary content
    static let inkuBodySmall: Font = .callout

    // MARK: - Caption

    /// Metadata, timestamps
    static let inkuCaption: Font = .caption

    /// Smallest text, badges
    static let inkuCaptionSmall: Font = .caption2

    // MARK: - Icon Sizes

    /// Large icon for empty states, hero sections (scales with largeTitle)
    static let inkuIconLarge: Font = .largeTitle

    /// Medium icon for empty states (scales with title)
    static let inkuIconMedium: Font = .title

    /// Small icon for inline elements (scales with title2)
    static let inkuIconSmall: Font = .title2
}

//
//  InkuTabView.swift
//  InkuUI
//
//  Created by Eduardo Andrade on 02/01/26.
//

import SwiftUI

/// A ViewModifier that applies Inku visual identity to TabView
///
/// Provides consistent accent colors and styling for tab bars throughout the app.
///
/// Example usage:
/// ```swift
/// TabView {
///     Tab("Browse", systemImage: "books.vertical") {
///         BrowseView()
///     }
///
///     Tab("Search", systemImage: "magnifyingglass", role: .search) {
///         SearchView()
///     }
/// }
/// .inkuTabStyle()
/// ```
public struct InkuTabStyle: ViewModifier {

    // MARK: - Body

    public func body(content: Content) -> some View {
        content
            .tint(Color.inkuAccentStrong)
    }
}

public extension View {

    /// Apply Inku visual identity to a TabView
    ///
    /// This modifier applies Inku's accent colors to tab bars for consistent styling.
    func inkuTabStyle() -> some View {
        modifier(InkuTabStyle())
    }
}

// MARK: - Previews

#Preview("InkuTabStyle") {
    TabView {
        Tab("Browse", systemImage: "books.vertical") {
            NavigationStack {
                VStack(spacing: InkuSpacing.spacing24) {
                    Image(systemName: "books.vertical")
                        .font(.inkuIconLarge)
                        .foregroundStyle(Color.inkuAccent)

                    Text("Browse Tab")
                        .font(.inkuDisplayMedium)
                        .foregroundStyle(Color.inkuText)

                    Text("Discover your next favorite manga")
                        .font(.inkuBodySmall)
                        .foregroundStyle(Color.inkuTextSecondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.inkuSurface)
                .navigationTitle("Browse")
            }
        }

        Tab("Search", systemImage: "magnifyingglass", role: .search) {
            NavigationStack {
                VStack(spacing: InkuSpacing.spacing24) {
                    Image(systemName: "magnifyingglass")
                        .font(.inkuIconLarge)
                        .foregroundStyle(Color.inkuAccent)

                    Text("Search Tab")
                        .font(.inkuDisplayMedium)
                        .foregroundStyle(Color.inkuText)

                    Text("Find manga by title or genre")
                        .font(.inkuBodySmall)
                        .foregroundStyle(Color.inkuTextSecondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.inkuSurface)
                .navigationTitle("Search")
            }
        }

        Tab("Library", systemImage: "books.vertical.fill") {
            NavigationStack {
                VStack(spacing: InkuSpacing.spacing24) {
                    Image(systemName: "books.vertical.fill")
                        .font(.inkuIconLarge)
                        .foregroundStyle(Color.inkuAccent)

                    Text("Library Tab")
                        .font(.inkuDisplayMedium)
                        .foregroundStyle(Color.inkuText)

                    Text("Your saved manga collection")
                        .font(.inkuBodySmall)
                        .foregroundStyle(Color.inkuTextSecondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.inkuSurface)
                .navigationTitle("Library")
            }
        }
        #if !os(tvOS)
        .badge(3)
        #endif
    }
    .inkuTabStyle()
}

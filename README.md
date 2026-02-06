# InkuUI

A comprehensive SwiftUI design system for building beautiful manga/comic reader applications.

## Features

- 🎨 **Design Tokens** - Consistent spacing, radius, colors, and typography
- 🧩 **Reusable Components** - Pre-built UI components for common patterns
- ✨ **Skeleton Loading** - Granular shimmer effects for content placeholders
- 🌓 **Dark Mode** - Adaptive colors with light/dark mode support
- 📱 **iOS 18+** - Modern SwiftUI patterns and best practices
- 🔧 **Highly Customizable** - Flexible APIs with sensible defaults

## Requirements

- iOS 18.0+ / macOS 15.0+ / tvOS 18.0+
- Swift 6.2+
- Xcode 16.0+

## Installation

### Swift Package Manager

Add InkuUI to your project using Xcode:

1. Go to **File** > **Add Package Dependencies...**
2. Enter the repository URL: `https://github.com/Eduardo0224/InkuUI.git`
3. Select **Up to Next Major Version** and click **Add Package**

Or add it to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/Eduardo0224/InkuUI.git", from: "1.0.0")
]
```

## Quick Start

Import InkuUI in your SwiftUI views:

```swift
import SwiftUI
import InkuUI

struct ContentView: View {
    var body: some View {
        InkuMangaCard(
            imageURL: URL(string: "https://example.com/cover.jpg"),
            title: "One Piece",
            subtitle: "Eiichiro Oda",
            badge: "Shounen"
        )
        .frame(width: 160)
    }
}
```

## Components

### Design Tokens

#### Spacing
8pt grid system for consistent layouts:
```swift
InkuSpacing.spacing4   // 4pt
InkuSpacing.spacing8   // 8pt
InkuSpacing.spacing12  // 12pt
InkuSpacing.spacing16  // 16pt
// ... up to spacing48
```

#### Corner Radius
```swift
InkuRadius.radius4   // Small elements
InkuRadius.radius8   // Medium elements
InkuRadius.radius12  // Cards, buttons
InkuRadius.radius16  // Large containers
```

#### Colors
Adaptive colors with automatic light/dark mode:
```swift
Color.inkuAccent           // Primary accent color
Color.inkuSurface          // Background surface
Color.inkuText             // Primary text
Color.inkuTextSecondary    // Secondary text
```

#### Typography
```swift
Font.inkuHeadline      // Large headlines
Font.inkuTitle         // Section titles
Font.inkuBody          // Body text
Font.inkuCaption       // Small captions
```

### UI Components

#### InkuBadge
Compact labels for categories, tags, or status:
```swift
InkuBadge(text: "Shounen", style: .accent)
InkuBadge(text: "Ongoing", style: .secondary)
InkuBadge(text: "New", style: .outlined)
```

#### InkuButton
Customizable buttons with three styles:
```swift
InkuButton("Continue", style: .primary) { /* action */ }
InkuButton("Cancel", style: .secondary) { /* action */ }
InkuButton("Skip", icon: "arrow.right", style: .ghost) { /* action */ }
```

#### InkuCoverImage
Async image loader with automatic skeleton state:
```swift
InkuCoverImage(url: coverURL)
InkuCoverImage(url: coverURL, cornerRadius: 8)
```

#### InkuMangaCard
Vertical card for manga/comic information:
```swift
InkuMangaCard(
    imageURL: coverURL,
    title: "Attack on Titan",
    subtitle: "Hajime Isayama",
    badge: "Seinen",
    isLoading: false
)
```

#### InkuEmptyView
Empty state with icon and optional action:
```swift
InkuEmptyView(
    icon: "book",
    title: "Library is empty",
    subtitle: "Start adding manga to your collection",
    actionTitle: "Browse Catalog"
) {
    // Action
}
```

#### InkuErrorView
Error state with retry option:
```swift
InkuErrorView(
    message: "Failed to load data",
    retryActionTitle: "Try Again"
) {
    // Retry action
}
```

#### InkuLoadingView
Centered loading indicator:
```swift
InkuLoadingView()
InkuLoadingView(message: "Loading manga...")
```

### View Modifiers

#### Skeleton Loading
Granular shimmer effect for content placeholders:
```swift
VStack {
    Text("Loading...")
    Text("Please wait")
}
.inkuSkeleton(isLoading)
```

#### Card Style
Elevated card surface:
```swift
content
    .inkuCard()
    .inkuCard(cornerRadius: 16, shadowRadius: 8)
```

#### Glass Effect
Glassmorphism effect (iOS 18+):
```swift
content
    .inkuGlass(isEnabled: true)
```

## Screenshots

### Components

<table>
  <tr>
    <th>Badge Styles</th>
    <th>Buttons</th>
    <th>Cover Image</th>
    <th>Manga Card</th>
  </tr>
  <tr>
    <td align="center"><img src="https://github.com/user-attachments/assets/82bb5308-c1ae-4044-9a7a-96e91a3b1e01" alt="Badge Styles" width="200"/></td>
    <td align="center"><img src="https://github.com/user-attachments/assets/e0c7724c-4e80-42d0-9ac1-421394ccf763" alt="Buttons" width="200"/></td>
    <td align="center"><img src="https://github.com/user-attachments/assets/355bbde5-32e8-40c1-ae70-a250beb8cf1c" alt="Cover Image" width="200"/></td>
    <td align="center"><img src="https://github.com/user-attachments/assets/da2606e2-c302-409c-8b6b-382b266dcfbe" alt="Manga Card" width="200"/></td>
  </tr>
</table>

### States

<table>
  <tr>
    <th>Loading State</th>
    <th>Empty State</th>
    <th>Error State</th>
    <th>Skeleton Loading</th>
  </tr>
  <tr>
    <td align="center"><img src="https://github.com/user-attachments/assets/4de135c9-ce6c-47b4-8bf6-8fddef89bcf7" alt="Loading State" width="200"/></td>
    <td align="center"><img src="https://github.com/user-attachments/assets/65609786-cd0f-4092-96d7-4de073a3a540" alt="Empty State" width="200"/></td>
    <td align="center"><img src="https://github.com/user-attachments/assets/56a29630-2eb8-48fd-80d6-5a2af262a7da" alt="Error State" width="200"/></td>
    <td align="center"><img src="https://github.com/user-attachments/assets/65d99875-9232-43aa-b1d5-208b99c4325d" alt="Skeleton Loading" width="200"/></td>
  </tr>
</table>

## Usage Examples

### Skeleton Loading Pattern

Apply skeleton loading to individual components for granular control:

```swift
struct MangaListView: View {
    @State private var isLoading = true

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(manga) { item in
                    InkuMangaCard(
                        imageURL: item.coverURL,
                        title: item.title,
                        subtitle: item.author,
                        badge: item.genre,
                        isLoading: isLoading
                    )
                }
            }
        }
    }
}
```

### Custom Card Layout

```swift
VStack(spacing: InkuSpacing.spacing16) {
    InkuCoverImage(url: coverURL)
        .aspectRatio(2/3, contentMode: .fit)

    VStack(alignment: .leading, spacing: InkuSpacing.spacing8) {
        Text(title)
            .font(.inkuHeadline)
            .foregroundStyle(Color.inkuText)

        Text(subtitle)
            .font(.inkuCaption)
            .foregroundStyle(Color.inkuTextSecondary)
    }
}
.padding(InkuSpacing.spacing16)
.inkuCard()
```

### Handling Loading States

```swift
struct ContentView: View {
    enum ViewState {
        case loading
        case loaded([Manga])
        case empty
        case error(String)
    }

    @State private var state: ViewState = .loading

    var body: some View {
        Group {
            switch state {
            case .loading:
                InkuLoadingView(message: "Loading manga...")

            case .loaded(let items):
                MangaGrid(items: items)

            case .empty:
                InkuEmptyView(
                    icon: "book",
                    title: "No manga found",
                    actionTitle: "Browse Catalog"
                ) {
                    browseCatalog()
                }

            case .error(let message):
                InkuErrorView(
                    message: message,
                    retryActionTitle: "Try Again"
                ) {
                    loadData()
                }
            }
        }
    }
}
```

## Documentation

All public components and modifiers include inline documentation. Use Xcode's **Quick Help** (⌥ + Click) to view usage examples and parameter descriptions.

### Design Guidelines

- **Granular Skeleton Loading**: Apply `.inkuSkeleton()` to content elements (Text, Image), not layout modifiers (background, padding)
- **Color Usage**: Use semantic color tokens (`.inkuText`, `.inkuSurface`) instead of hardcoded values
- **Spacing Consistency**: Use InkuSpacing tokens for all spacing to maintain the 8pt grid
- **Component Composition**: Build complex UIs by composing simple components

## License

InkuUI is available under the MIT License. See the [LICENSE](LICENSE) file for more info.

Copyright © 2025 Eduardo Andrade

---

Built with ❤️ for the Inku manga reader app

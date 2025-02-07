# SimpleCats

## Description
An iOS app that showcases cat images and their breed information using The Cat API.

## Setup Instructions

### Prerequisites
- Xcode 16.0 or later
- iOS 17.0 or later
- Swift 5.9 or later

## Installation
1. Unzip project
2. Open `SimpleCats.xcodeproj`
3. Build and run the project using Xcode's built-in simulator or a connected iOS device.

## Project Dependencies

The project uses Swift Package Manager (SPM) for dependency management. The following packages are included:

- **Kingfisher** (7.0.0 or later)
  - Used for efficient image loading and caching
  - Handles placeholder images and loading states

## Running Tests

### Unit Tests
```bash
# Using Xcode
Command + U

# Using terminal
xcodebuild test -scheme SimpleCats -destination 'platform=iOS Simulator,name=iPhone 15 Pro'
```

### UI Tests
- Select iPhone simulator
- Run `SimpleCatsUITests` in Xcode's test navigator

## Architecture

1. **SwiftUI**
   - Modern declarative UI framework
   - Better state management
   - Native integration with async/await

2. **MVVM Architecture**
   - Clear separation of concerns
   - Better testability
   - SwiftUI natural fit

3. **Dependency Injection**
   - Improved testability
   - Better maintainability
   - Easier mocking for tests

4. **Error Handling**
   - Comprehensive error handling with user feedback
   - Custom error types for different scenarios

5. **Image Loading**
   - Kingfisher for efficient image caching
   - Placeholder images during loading
   - Error state handling

6. **Infinite Scrolling**
   - Pagination for better performance
   - Smooth scrolling experience
   - Memory efficient

### Key Components

#### Models
- `CatImage`: Represents a cat image with associated breed information
- `Breed`: Contains detailed information about cat breeds

#### Views
- `CatListView`: Main view displaying the collection of cat images
- `CatDetailView`: Detailed view for individual cats
- `CatImageCell`: Reusable cell component for the list

#### ViewModels
- `CatListViewModel`: Manages the state and business logic for the cat list
  - Handles pagination
  - Manages loading states
  - Handles error scenarios

## Project Structure
```
SimpleCats/
├── SimpleCats/
│   ├── Core/
│   │   └── Network/
│   │       ├── Models/
│   │       │   ├── CatBreed.swift
│   │       │   ├── CatImage.swift
│   │       │   ├── NetworkManager.swift
│   │       │   └── TheCatAPI.swift
│   │       └── Protocols/
│   │           ├── APIEndpointProtocol.swift
│   │           ├── NetworkClientProtocol.swift
│   │           └── NetworkProtocol.swift
│   └── Modules/
│       ├── CatDetails/
│       │   ├── CatDetailView.swift
│       │   └── CatDetailViewModel.swift
│       └── CatList/
│           ├── CatListView.swift
│           └── CatListViewModel.swift
├── SimpleCatsTests/
│   ├── Mocks/
│   │   └── NetworkManagerTests.swift
│   └── SimpleCatsTests.swift
└── SimpleCatsUITests/
    ├── CatListViewUITests.swift
    ├── SimpleCatsUITests.swift
    └── SimpleCatsUITestsLaunchTests.swift
```


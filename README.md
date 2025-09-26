# swift-github-live

[![Swift](https://img.shields.io/badge/Swift-6.0-orange.svg)](https://swift.org)
[![License](https://img.shields.io/badge/License-AGPL%203.0-blue.svg)](LICENSE.md)
[![Version](https://img.shields.io/badge/version-0.1.0-green.svg)](https://github.com/coenttb/swift-github-live/releases)

Live implementations for GitHub API interactions in Swift server applications.

## Overview

`swift-github-live` provides production-ready implementations for GitHub's REST API with:

- 🌐 **Live Networking**: Async/await based HTTP client implementations
- 🔐 **Authentication**: GitHub token and OAuth app authentication support
- 📊 **Traffic Analytics**: Real-time repository traffic data fetching
- ⭐ **Stargazers**: Live stargazer data retrieval
- 📦 **Repositories**: Repository management operations
- 🚀 **Server Integration**: Built on swift-server-foundation
- ⚡ **High Performance**: Efficient connection pooling and request handling
- 🧪 **Testable**: Dependency injection with swift-dependencies

## Installation

Add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/coenttb/swift-github-live", from: "0.1.0")
]
```

## Quick Start

### Basic Setup

```swift
import GitHubLive
import GitHubTrafficLive
import Dependencies

### Fetching Repository Traffic

```swift
import GitHub

@Dependency(\.github.client.traffic) var traffic

// Get repository views
let views = try await traffic.views(
    owner: "coenttb",
    repo: "swift-github-live"
)

// Get clone statistics
let clones = try await traffic.clones(
    owner: "coenttb", 
    repo: "swift-github-live",
    per: .week
)
```

### Working with Stargazers

```swift
import GitHub

@Dependency(\.github.client.stargazers) var stargazers


// Get stargazers with timestamps
let result = try await stargazers.list(
    owner: "coenttb",
    repo: "swift-github-live",
    page: 1,
    perPage: 100
)
```

## Architecture

The package is organized into modular components:

- **GitHubLiveShared**: Shared networking and authentication utilities
- **GitHubTrafficLive**: Traffic analytics implementations
- **GitHubRepositoriesLive**: Repository operations
- **GitHubStargazersLive**: Stargazer data fetching
- **GitHubLive**: Main module with complete client

### Dependencies

Built on robust foundations:

- [swift-github-types](https://github.com/coenttb/swift-github-types): Type definitions
- [swift-server-foundation](https://github.com/coenttb/swift-server-foundation): Server utilities
- [swift-authenticating](https://github.com/coenttb/swift-authenticating): Authentication support

## Testing

Includes test utilities for easy testing:

```swift
import GitHubLive
import DependenciesTestSupport

@Test
func testGitHubOperations() async throws {
    await withDependencies {
        $0.githubClient = .test
    } operation: {
        // Test your GitHub operations
    }
}
```

## Related Packages

- [swift-github-types](https://github.com/coenttb/swift-github-types): Core types (Apache 2.0)
- [swift-github](https://github.com/coenttb/swift-github): High-level client wrapper
- [coenttb-com-server](https://github.com/coenttb/coenttb-com-server): Production example

## Requirements

- Swift 6.0+
- macOS 14+ / iOS 17+ / Linux

## License

This package is licensed under the AGPL 3.0 License. See [LICENSE.md](LICENSE.md) for details.

For commercial licensing options, please contact the maintainer.

## Support

For issues, questions, or contributions, please visit the [GitHub repository](https://github.com/coenttb/swift-github-live).

# swift-github-live

[![CI](https://github.com/coenttb/swift-github-live/workflows/CI/badge.svg)](https://github.com/coenttb/swift-github-live/actions/workflows/ci.yml)
![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

Live implementations for GitHub API interactions in Swift server applications.

## Overview

`swift-github-live` provides production-ready implementations for GitHub's REST API with:

- **Live Networking**: Async/await based HTTP client implementations
- **Authentication**: Bearer token authentication with swift-authenticating
- **Traffic Analytics**: Repository views, clones, paths, and referrer data
- **Stargazers**: Stargazer listing with pagination support
- **Repositories**: Repository CRUD operations (list, get, create, update, delete)
- **OAuth**: OAuth app authorization flows
- **Collaborators**: Repository collaborator management
- **Modular Design**: Separate targets for each API domain
- **Testable**: Dependency injection with swift-dependencies

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
import GitHub_Live
import Dependencies

// Access the GitHub client
@Dependency(\.github) var github

// Use traffic client
let views = try await github.client.traffic.views("coenttb", "swift-github-live", nil)
print("Total views: \(views.count)")

// Use repositories client
let repo = try await github.client.repositories.get("coenttb", "swift-github-live")
print("Repository: \(repo.name)")
```

### Fetching Repository Traffic

```swift
import GitHub_Live
import GitHub_Traffic_Types
import Dependencies

@Dependency(\.github) var github

// Get repository views
let views = try await github.client.traffic.views(
    "coenttb",
    "swift-github-live",
    nil
)
print("Total views: \(views.count)")

// Get clone statistics
let clones = try await github.client.traffic.clones(
    "coenttb",
    "swift-github-live",
    .week
)
print("Total clones: \(clones.count)")

// Get top referral paths
let paths = try await github.client.traffic.paths("coenttb", "swift-github-live")
print("Top paths: \(paths.paths.count)")

// Get top referrers
let referrers = try await github.client.traffic.referrers("coenttb", "swift-github-live")
print("Referrers: \(referrers.referrers.count)")
```

### Working with Stargazers

```swift
import GitHub_Live
import GitHub_Stargazers_Types
import Dependencies

@Dependency(\.github) var github

// Get stargazers with pagination
let request = GitHub.Stargazers.List.Request(perPage: 100, page: 1)
let response = try await github.client.stargazers.list(
    "coenttb",
    "swift-github-live",
    request
)
print("Stargazers: \(response.count)")
```

### Repository Management

```swift
import GitHub_Live
import GitHub_Repositories_Types
import Dependencies

@Dependency(\.github) var github

// Get a repository
let repo = try await github.client.repositories.get("coenttb", "swift-github-live")
print("Repository: \(repo.name)")

// List repositories
let listRequest = GitHub.Repositories.List.Request(
    visibility: .public,
    sort: .updated,
    direction: .desc
)
let repos = try await github.client.repositories.list(listRequest)

// Create a repository
let createRequest = GitHub.Repositories.Create.Request(
    name: "new-repo",
    description: "A new repository",
    private: false
)
let newRepo = try await github.client.repositories.create(createRequest)

// Update a repository
let updateRequest = GitHub.Repositories.Update.Request(
    description: "Updated description"
)
let updated = try await github.client.repositories.update("coenttb", "new-repo", updateRequest)

// Delete a repository
let deleteResponse = try await github.client.repositories.delete("coenttb", "new-repo")
```

## Architecture

The package is organized into modular components:

```
GitHub Live Shared
    ├── Authenticated wrapper (Bearer token auth)
    ├── URLRequest.Handler.GitHub (request handling)
    └── Environment variable configuration

GitHub Traffic Live → Traffic analytics
GitHub Repositories Live → Repository CRUD
GitHub Stargazers Live → Stargazer data
GitHub OAuth Live → OAuth flows
GitHub Collaborators Live → Collaborator management

GitHub Live → Complete client (combines all above)
```

### Module Structure

- **GitHub Live Shared**: Authentication and request handling utilities shared across all live implementations
- **GitHub Traffic Live**: Live implementation of traffic analytics (views, clones, paths, referrers)
- **GitHub Repositories Live**: Live implementation of repository operations (list, get, create, update, delete)
- **GitHub Stargazers Live**: Live implementation of stargazer listing with pagination
- **GitHub OAuth Live**: Live implementation of OAuth authorization flows
- **GitHub Collaborators Live**: Live implementation of collaborator management
- **GitHub Live**: Main module that combines all feature clients into a unified interface

### Dependencies

Built on robust foundations:

- [swift-github-types](https://github.com/coenttb/swift-github-types): A Swift package with foundational types for GitHub.
- [swift-server-foundation](https://github.com/coenttb/swift-server-foundation): A Swift package with tools to simplify server development.
- [swift-authenticating](https://github.com/coenttb/swift-authenticating): A Swift package for type-safe HTTP authentication with URL routing integration.
- [swift-dependencies](https://github.com/pointfreeco/swift-dependencies): Dependency injection framework

## Testing

The package uses dependency injection for testability:

```swift
import GitHub_Live
import Dependencies
import DependenciesTestSupport
import Testing

@Test
func testGitHubOperations() async throws {
    await withDependencies {
        $0.github = .testValue
    } operation: {
        @Dependency(\.github) var github
        // Test your GitHub operations with mock client
    }
}
```

### Environment Variables for Testing

The package requires the following environment variables for live integration tests:

- `GITHUB_TOKEN`: Personal access token for authentication
- `GITHUB_BASE_URL`: GitHub API base URL (defaults to https://api.github.com)
- `GITHUB_TEST_OWNER`: Owner name for test repository
- `GITHUB_TEST_REPO`: Repository name for testing

## Related Packages

### Dependencies

- [swift-authenticating](https://github.com/coenttb/swift-authenticating): A Swift package for type-safe HTTP authentication with URL routing integration.
- [swift-github-types](https://github.com/coenttb/swift-github-types): A Swift package with foundational types for GitHub.
- [swift-server-foundation](https://github.com/coenttb/swift-server-foundation): A Swift package with tools to simplify server development.

### Used By

- [swift-github](https://github.com/coenttb/swift-github): A Swift package for the GitHub API.
- [swift-identities-github](https://github.com/coenttb/swift-identities-github): A Swift package integrating GitHub OAuth with swift-identities.

### Third-Party Dependencies

- [pointfreeco/swift-dependencies](https://github.com/pointfreeco/swift-dependencies): A dependency management library for controlling dependencies in Swift.

## Requirements

- Swift 6.0+
- macOS 14+ / iOS 17+ / Linux

## License

This package is licensed under the AGPL 3.0 License. See [LICENSE.md](LICENSE.md) for details.

For commercial licensing options, please contact the maintainer.

## Support

For issues, questions, or contributions, please visit the [GitHub repository](https://github.com/coenttb/swift-github-live).

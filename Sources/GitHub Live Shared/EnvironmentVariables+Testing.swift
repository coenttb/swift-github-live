//
//  EnvironmentVariables+Testing.swift
//  swift-github-live
//
//  Created by Coen ten Thije Boonkkamp on 22/08/2025.
//

import EnvironmentVariables
import Foundation

// MARK: - Test Environment Variables

extension EnvironmentVariables {
  // Test repository configuration
  public var githubTestOwner: String {
    get { self["GITHUB_TEST_OWNER"] ?? "octocat" }
    set { self["GITHUB_TEST_OWNER"] = newValue }
  }

  public var githubTestRepo: String {
    get { self["GITHUB_TEST_REPO"] ?? "Hello-World" }
    set { self["GITHUB_TEST_REPO"] = newValue }
  }
}

// MARK: - Development Environment

extension EnvironmentVariables {
  /// Development environment configuration for testing
  /// Loads from .env file in project root
  package static var development: Self {
    let projectRoot = URL(fileURLWithPath: #filePath)
      .deletingLastPathComponent()  // GitHub Live Shared
      .deletingLastPathComponent()  // Sources
      .deletingLastPathComponent()  // swift-github-live

    return try! .live(
      environmentConfiguration: .projectRoot(
        projectRoot,
        environment: "development"
      ),
      requiredKeys: [
        "GITHUB_TOKEN",
        "GITHUB_BASE_URL",
      ]
    )
  }
}

// MARK: - Context for Testing

extension DependencyValues {
  struct Context: Sendable {
    enum ContextType: Sendable {
      case live
      case test
    }

    let type: ContextType

    static let live = Context(type: .live)
    static let test = Context(type: .test)
  }

  var context: Context {
    get { self[ContextKey.self] }
    set { self[ContextKey.self] = newValue }
  }

  private enum ContextKey: DependencyKey {
    static let liveValue = Context.test
    static let testValue = Context.test
  }
}

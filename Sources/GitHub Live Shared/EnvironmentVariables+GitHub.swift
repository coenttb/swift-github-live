//
//  EnvironmentVariables+GitHub.swift
//  swift-github-live
//
//  Created by Coen ten Thije Boonkkamp on 22/08/2025.
//

extension EnvironmentVariables {
  public var githubBaseUrl: URL {
    get {
      self["GITHUB_BASE_URL"]
        .flatMap(URL.init(string:))
        ?? URL(string: "https://api.github.com")!
    }
    set { self["GITHUB_BASE_URL"] = newValue.absoluteString }
  }

  public var githubToken: String {
    get { self["GITHUB_TOKEN"] ?? "" }
    set { self["GITHUB_TOKEN"] = newValue }
  }

  public var githubApiVersion: String {
    get { self["GITHUB_API_VERSION"] ?? "2022-11-28" }
    set { self["GITHUB_API_VERSION"] = newValue }
  }
}

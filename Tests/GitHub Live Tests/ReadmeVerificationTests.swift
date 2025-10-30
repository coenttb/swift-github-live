//
//  ReadmeVerificationTests.swift
//  swift-github-live
//
//  Verification tests for README.md code examples
//

import Dependencies
import DependenciesTestSupport
import GitHub_Live
import GitHub_Types
import GitHub_Traffic_Types
import GitHub_Stargazers_Types
import GitHub_Repositories_Types
import Testing
import Foundation

@Suite("README Verification Tests")
struct ReadmeVerificationTests {

    // MARK: - Lines 36-50: Basic Setup

    @Test("README Lines 36-50: Basic Setup - GitHub client access")
    func basicSetupExample() async throws {
        func exampleCode() async throws {
            @Dependency(\.github) var github

            // Verify client structure exists
            _ = github.client.traffic
            _ = github.client.repositories
            _ = github.client.stargazers
            _ = github.client.oauth
            _ = github.client.collaborators
        }

        // Verify compilation only - testValue uses liveValue which requires env vars
        // Just verify the code compiles
    }

    // MARK: - Lines 54-84: Fetching Repository Traffic

    @Test("README Lines 62-67: Traffic views example")
    func trafficViewsExample() async throws {
        func exampleCode() async throws {
            @Dependency(\.github) var github

            let views = try await github.client.traffic.views(
                "coenttb",
                "swift-github-live",
                nil
            )
            #expect(views.count >= 0)
        }

        // Verify compilation only
        // Actual execution would require valid GitHub token
    }

    @Test("README Lines 70-75: Traffic clones example")
    func trafficClonesExample() async throws {
        func exampleCode() async throws {
            @Dependency(\.github) var github

            let clones = try await github.client.traffic.clones(
                "coenttb",
                "swift-github-live",
                .week
            )
            #expect(clones.count >= 0)
        }

        // Verify compilation only
    }

    @Test("README Lines 78-79: Traffic paths example")
    func trafficPathsExample() async throws {
        func exampleCode() async throws {
            @Dependency(\.github) var github

            let paths = try await github.client.traffic.paths("coenttb", "swift-github-live")
            #expect(paths.paths.count >= 0)
        }

        // Verify compilation only
    }

    @Test("README Lines 82-83: Traffic referrers example")
    func trafficReferrersExample() async throws {
        func exampleCode() async throws {
            @Dependency(\.github) var github

            let referrers = try await github.client.traffic.referrers("coenttb", "swift-github-live")
            #expect(referrers.referrers.count >= 0)
        }

        // Verify compilation only
    }

    // MARK: - Lines 88-103: Working with Stargazers

    @Test("README Lines 95-102: Stargazers list example")
    func stargazersListExample() async throws {
        func exampleCode() async throws {
            @Dependency(\.github) var github

            let request = GitHub.Stargazers.List.Request(perPage: 100, page: 1)
            let response = try await github.client.stargazers.list(
                "coenttb",
                "swift-github-live",
                request
            )
            #expect(response.count >= 0)
        }

        // Verify compilation only
    }

    // MARK: - Lines 107-142: Repository Management

    @Test("README Lines 115-116: Get repository example")
    func repositoryGetExample() async throws {
        func exampleCode() async throws {
            @Dependency(\.github) var github

            let repo = try await github.client.repositories.get("coenttb", "swift-github-live")
            #expect(!repo.name.isEmpty)
        }

        // Verify compilation only
    }

    @Test("README Lines 119-124: List repositories example")
    func repositoryListExample() async throws {
        func exampleCode() async throws {
            @Dependency(\.github) var github

            let listRequest = GitHub.Repositories.List.Request(
                visibility: .public,
                sort: .updated,
                direction: .desc
            )
            let repos = try await github.client.repositories.list(listRequest)
            #expect(repos.count >= 0)
        }

        // Verify compilation only
    }

    @Test("README Lines 127-132: Create repository example")
    func repositoryCreateExample() async throws {
        func exampleCode() async throws {
            @Dependency(\.github) var github

            let createRequest = GitHub.Repositories.Create.Request(
                name: "new-repo",
                description: "A new repository",
                private: false
            )
            let newRepo = try await github.client.repositories.create(createRequest)
            #expect(newRepo.name == "new-repo")
        }

        // Verify compilation only - should not actually create repo in tests
    }

    @Test("README Lines 135-138: Update repository example")
    func repositoryUpdateExample() async throws {
        func exampleCode() async throws {
            @Dependency(\.github) var github

            let updateRequest = GitHub.Repositories.Update.Request(
                description: "Updated description"
            )
            let updated = try await github.client.repositories.update("coenttb", "new-repo", updateRequest)
            #expect(!updated.name.isEmpty)
        }

        // Verify compilation only
    }

    @Test("README Lines 141: Delete repository example")
    func repositoryDeleteExample() async throws {
        func exampleCode() async throws {
            @Dependency(\.github) var github

            let deleteResponse = try await github.client.repositories.delete("coenttb", "new-repo")
            // Verify compilation - delete returns response
            _ = deleteResponse
        }

        // Verify compilation only - should not actually delete repo in tests
    }

    // MARK: - Lines 187-201: Testing Example

    @Test("README Lines 192-200: Testing with dependencies example")
    func testingExample() async throws {
        // Inner function to demonstrate the README example
        func testGitHubOperations() async throws {
            // Note: testValue uses liveValue which requires environment variables
            // This test just verifies the code structure compiles
            @Dependency(\.github) var github

            // Verify client is accessible
            _ = github.client.traffic
            _ = github.client.repositories
            _ = github.client.stargazers
        }

        // Verify the example code compiles
        try await testGitHubOperations()
    }

    // MARK: - Type Verification Tests

    @Test("Verify module imports compile correctly")
    func moduleImportsTest() async throws {
        // Verify all necessary imports are valid
        @Dependency(\.github) var github

        // Check client structure
        let client = github.client
        #expect(type(of: client) == GitHub.Client.self)

        // Verify sub-clients exist
        _ = client.traffic
        _ = client.repositories
        _ = client.stargazers
        _ = client.oauth
        _ = client.collaborators
    }

    @Test("Verify Traffic types compile correctly")
    func trafficTypesTest() async throws {
        // Verify traffic types are accessible
        _ = GitHub.Traffic.Views.Response.self
        _ = GitHub.Traffic.Clones.Response.self
        _ = GitHub.Traffic.Paths.Response.self
        _ = GitHub.Traffic.Referrers.Response.self
        _ = GitHub.Traffic.Per.self
    }

    @Test("Verify Stargazers types compile correctly")
    func stargazersTypesTest() async throws {
        // Verify stargazers types are accessible
        _ = GitHub.Stargazers.List.Request.self
        _ = GitHub.Stargazers.List.Response.self
    }

    @Test("Verify Repositories types compile correctly")
    func repositoriesTypesTest() async throws {
        // Verify repositories types are accessible
        _ = GitHub.Repository.self
        _ = GitHub.Repositories.List.Request.self
        _ = GitHub.Repositories.List.Response.self
        _ = GitHub.Repositories.Create.Request.self
        _ = GitHub.Repositories.Update.Request.self
        _ = GitHub.Repositories.Delete.Response.self
    }

    @Test("Verify client architecture structure")
    func clientArchitectureTest() async throws {
        @Dependency(\.github) var github

        // Verify the main client provides access to all sub-clients
        let client = github.client

        // Traffic client
        let trafficClient = client.traffic
        #expect(type(of: trafficClient) == GitHub.Traffic.Client.self)

        // Repositories client
        let reposClient = client.repositories
        #expect(type(of: reposClient) == GitHub.Repositories.Client.self)

        // Stargazers client
        let stargazersClient = client.stargazers
        #expect(type(of: stargazersClient) == GitHub.Stargazers.Client.self)

        // OAuth client
        let oauthClient = client.oauth
        #expect(type(of: oauthClient) == GitHub.OAuth.Client.self)

        // Collaborators client
        let collaboratorsClient = client.collaborators
        #expect(type(of: collaboratorsClient) == GitHub.Collaborators.Client.self)
    }

    @Test("Verify dependency injection setup")
    func dependencyInjectionTest() async throws {
        // Test that GitHub client is available as a dependency
        @Dependency(\.github) var github

        // Verify client is accessible
        _ = github.client

        // Verify router is accessible
        _ = github.router
    }

    @Test("Verify Authenticated wrapper structure")
    func authenticatedWrapperTest() async throws {
        @Dependency(\.github) var github

        // Verify the authenticated wrapper provides client and router
        _ = github.client
        _ = github.router

        // Verify type is GitHub.Authenticated
        #expect(type(of: github) == GitHub.Authenticated.self)
    }
}

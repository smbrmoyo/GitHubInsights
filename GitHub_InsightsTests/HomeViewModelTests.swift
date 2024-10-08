//
//  HomeViewModelTests.swift
//  GitHub_InsightsTests
//
//  Created by Brian Moyou on 26.09.24.
//

import XCTest
@testable import GitHub_Insights

final class HomeViewModelTests: XCTestCase {
    
    private var sut: HomeViewModel!
    private var repository: MockHomeRepository!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        repository = MockHomeRepository.shared
        repository.shouldFail = false
        sut = HomeViewModel(repository: repository)
        UserDefaults.standard.removeObject(forKey: "GITHUB_USERNAME")
    }
    
    override func tearDownWithError() throws {
        sut = nil
        
        try super.tearDownWithError()
    }
    
    /**
     - Test: df
     - Given:
     */
    func testInitialValues() {
        // Given
        
        // When
        
        // Then
        XCTAssertEqual(sut.repositories, [])
        XCTAssertEqual(sut.uiState, .idle)
        XCTAssertEqual(sut.canRefresh, true)
        XCTAssertEqual(sut.page, 1)
    }
    
    func testFetchRepositoriesSuccess() async throws {
        // Given
        UserDefaults.standard.setValue("testUser", forKey: "GITHUB_USERNAME")
        let allRepos: [GitHubRepo] = try FileManager.loadJson(fileName: "Repositories")
        
        // When
        await sut.fetchRepositories()
        
        // Then
        XCTAssertEqual(sut.repositories.count, 10)
        XCTAssertEqual(sut.repositories, Array(allRepos.prefix(10)))
        XCTAssertEqual(sut.uiState, .idle)
        XCTAssertTrue(sut.canRefresh)
        XCTAssertEqual(sut.page, 2)
    }
    
    func testFetchRepositoriesPagination() async throws {
        // Given
        UserDefaults.standard.setValue("testUser", forKey: "GITHUB_USERNAME")
        let allRepos: [GitHubRepo] = try FileManager.loadJson(fileName: "Repositories")
        
        await sut.fetchRepositories()
        
        XCTAssertEqual(sut.repositories.count, 10)
        XCTAssertEqual(sut.repositories, Array(allRepos.prefix(10)))
        XCTAssertEqual(sut.uiState, .idle)
        XCTAssertEqual(sut.page, 2)
        XCTAssertTrue(sut.canRefresh)
        
        await sut.fetchRepositories()
        
        XCTAssertEqual(sut.repositories.count, 20)
        XCTAssertEqual(sut.repositories, Array(allRepos.prefix(20)))
        XCTAssertEqual(sut.uiState, .idle)
        XCTAssertEqual(sut.page, 3)
        XCTAssertTrue(sut.canRefresh)
        
        await sut.fetchRepositories()
        await sut.fetchRepositories()
        await sut.fetchRepositories()
        await sut.fetchRepositories()
        await sut.fetchRepositories()
        await sut.fetchRepositories()
        
        XCTAssertEqual(sut.repositories.count, 50)
        XCTAssertEqual(sut.repositories, allRepos)
        XCTAssertEqual(sut.uiState, .idle)
        XCTAssertEqual(sut.page, 6)
        XCTAssertFalse(sut.canRefresh)
    }
    
    func testFetchRepositoriesWithEmptyResult() async throws {
        // Given
        UserDefaults.standard.setValue("testUser", forKey: "GITHUB_USERNAME")
        
        // When
        sut.page = 6
        await sut.fetchRepositories()
        
        // Then
        XCTAssertEqual(sut.repositories.count, 0)
        XCTAssertEqual(sut.repositories, [])
        XCTAssertEqual(sut.uiState, .idle)
        XCTAssertFalse(sut.canRefresh)
        XCTAssertEqual(sut.page, 6)
    }
    
    func testFetchRepositoriesWithoutUsername() async {
        // Given
        // GitHub username is not set in UserDefaults
        
        // When
        await sut.fetchRepositories()
        
        // Then
        XCTAssertEqual(sut.repositories.count, 0)
        XCTAssertEqual(sut.uiState, .idle)
        XCTAssertEqual(sut.page, 1)
    }
    
    func testFetchRepositoriesFailure() async {
        // Given
        UserDefaults.standard.setValue("testUser", forKey: "GITHUB_USERNAME")
        
        // When
        repository.shouldFail = true
        await sut.fetchRepositories()
        
        // Then
        XCTAssertEqual(sut.repositories.count, 0)
        XCTAssertEqual(sut.uiState, .idle)
        XCTAssertFalse(sut.canRefresh)
        XCTAssertEqual(sut.page, 1)
        XCTAssertTrue(ToastManager.shared.toast?.style == .error)
        XCTAssertEqual(ToastManager.shared.toast?.message, "No repositories found.")
    }
    
}

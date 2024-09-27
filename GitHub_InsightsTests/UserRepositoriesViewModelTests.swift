//
//  UserRepositoriesViewModelTests.swift
//  GitHub_InsightsTests
//
//  Created by Brian Moyou on 27.09.24.
//

import XCTest
@testable import GitHub_Insights

final class UserRepositoriesViewModelTests: XCTestCase {
    
    private var sut: UserRepositoriesViewModel!
    private var repository: MockProfileRepository!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        repository = MockProfileRepository.shared
        repository.shouldFail = false
        sut = UserRepositoriesViewModel(repository: repository)
        UserDefaults.standard.removeObject(forKey: "GITHUB_USERNAME")
    }
    
    override func tearDownWithError() throws {
        sut = nil
        
        try super.tearDownWithError()
    }
    
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
        await sut.fetchUserRepositories()
        
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
        
        await sut.fetchUserRepositories()
        
        XCTAssertEqual(sut.repositories.count, 10)
        XCTAssertEqual(sut.repositories, Array(allRepos.prefix(10)))
        XCTAssertEqual(sut.uiState, .idle)
        XCTAssertEqual(sut.page, 2)
        XCTAssertTrue(sut.canRefresh)
        
        await sut.fetchUserRepositories()
        
        XCTAssertEqual(sut.repositories.count, 20)
        XCTAssertEqual(sut.repositories, Array(allRepos.prefix(20)))
        XCTAssertEqual(sut.uiState, .idle)
        XCTAssertEqual(sut.page, 3)
        XCTAssertTrue(sut.canRefresh)
        
        await sut.fetchUserRepositories()
        await sut.fetchUserRepositories()
        await sut.fetchUserRepositories()
        await sut.fetchUserRepositories()
        await sut.fetchUserRepositories()
        await sut.fetchUserRepositories()
        
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
        await sut.fetchUserRepositories()
        
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
        await sut.fetchUserRepositories()
        
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
        await sut.fetchUserRepositories()
        
        // Then
        XCTAssertEqual(sut.repositories.count, 0)
        XCTAssertEqual(sut.uiState, .idle)
        XCTAssertFalse(sut.canRefresh)
        XCTAssertEqual(sut.page, 1)
        XCTAssertTrue(ToastManager.shared.toast?.style == .error)
        XCTAssertEqual(ToastManager.shared.toast?.message, "No repositories found.")
    }
    
}

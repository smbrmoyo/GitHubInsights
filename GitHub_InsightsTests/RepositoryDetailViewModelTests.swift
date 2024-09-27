//
//  RepositoryDetailViewModelTests.swift
//  GitHub_InsightsTests
//
//  Created by Brian Moyou on 27.09.24.
//

import XCTest
@testable import GitHub_Insights

final class RepositoryDetailViewModelTests: XCTestCase {
    private var sut: RepositoryDetailViewModel!
    private var repository: MockHomeRepository!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        repository = MockHomeRepository.shared
        repository.shouldFail = false
        sut = RepositoryDetailViewModel(repository: repository, gitHubRepo: GitHubRepo.MOCK_GITHUB_REPO)
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
        XCTAssertEqual(sut.repositoryEvents, [])
        XCTAssertEqual(sut.uiState, .idle)
        XCTAssertEqual(sut.canRefresh, true)
        XCTAssertEqual(sut.page, 1)
    }
    
    func testFetchRepositoryEventsSuccess() async throws {
        // Given
        UserDefaults.standard.setValue("testUser", forKey: "GITHUB_USERNAME")
        let allEvents: [RepositoryEvent] = try FileManager.loadJson(fileName: "Events")
        
        // When
        await sut.fetchRepositoryEvents()
        
        // Then
        XCTAssertEqual(sut.repositoryEvents.count, 10)
        XCTAssertEqual(sut.repositoryEvents, Array(allEvents.prefix(10)))
        XCTAssertEqual(sut.uiState, .idle)
        XCTAssertTrue(sut.canRefresh)
        XCTAssertEqual(sut.page, 2)
    }
    
    func testFetchRepositoriesPagination() async throws {
        // Given
        UserDefaults.standard.setValue("testUser", forKey: "GITHUB_USERNAME")
        let allEvents: [RepositoryEvent] = try FileManager.loadJson(fileName: "Events")
        
        await sut.fetchRepositoryEvents()
        
        XCTAssertEqual(sut.repositoryEvents.count, 10)
        XCTAssertEqual(sut.repositoryEvents, Array(allEvents.prefix(10)))
        XCTAssertEqual(sut.uiState, .idle)
        XCTAssertEqual(sut.page, 2)
        XCTAssertTrue(sut.canRefresh)
        
        await sut.fetchRepositoryEvents()
        
        XCTAssertEqual(sut.repositoryEvents.count, 20)
        XCTAssertEqual(sut.repositoryEvents, Array(allEvents.prefix(20)))
        XCTAssertEqual(sut.uiState, .idle)
        XCTAssertEqual(sut.page, 3)
        XCTAssertTrue(sut.canRefresh)
        
        await sut.fetchRepositoryEvents()
        await sut.fetchRepositoryEvents()
        await sut.fetchRepositoryEvents()
        await sut.fetchRepositoryEvents()
        await sut.fetchRepositoryEvents()
        await sut.fetchRepositoryEvents()
        await sut.fetchRepositoryEvents()
        await sut.fetchRepositoryEvents()
        await sut.fetchRepositoryEvents()
        
        XCTAssertEqual(sut.repositoryEvents.count, 100)
        XCTAssertEqual(sut.repositoryEvents, allEvents)
        XCTAssertEqual(sut.uiState, .idle)
        XCTAssertEqual(sut.page, 11)
        XCTAssertFalse(sut.canRefresh)
    }
    
    func testFetchRepositoriesWithEmptyResult() async throws {
        // Given
        UserDefaults.standard.setValue("testUser", forKey: "GITHUB_USERNAME")
        
        // When
        sut.page = 11
        await sut.fetchRepositoryEvents()
        
        // Then
        XCTAssertEqual(sut.repositoryEvents.count, 0)
        XCTAssertEqual(sut.repositoryEvents, [])
        XCTAssertEqual(sut.uiState, .idle)
        XCTAssertFalse(sut.canRefresh)
        XCTAssertEqual(sut.page, 11)
    }
    
    func testFetchRepositoriesWithoutUsername() async {
        // Given
        // GitHub username is not set in UserDefaults
        
        // When
        await sut.fetchRepositoryEvents()
        
        // Then
        XCTAssertEqual(sut.repositoryEvents.count, 0)
        XCTAssertEqual(sut.uiState, .idle)
        XCTAssertEqual(sut.page, 1)
        XCTAssertFalse(sut.canRefresh)
    }
    
    func testFetchRepositoriesFailure() async {
            // Given
            UserDefaults.standard.setValue("testUser", forKey: "GITHUB_USERNAME")
            
            // When
            repository.shouldFail = true
            await sut.fetchRepositoryEvents()
            
            // Then
            XCTAssertEqual(sut.repositoryEvents.count, 0)
            XCTAssertEqual(sut.uiState, .idle)
            XCTAssertTrue(ToastManager.shared.toast?.style == .error)
            XCTAssertEqual(ToastManager.shared.toast?.message, "No Events found.")
        }
    

}

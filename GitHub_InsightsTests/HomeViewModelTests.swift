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

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        sut = HomeViewModel(repository: MockHomeRepository.shared)
        UserDefaults.standard.removeObject(forKey: "GITHUB_USERNAME")
    }

    override func tearDownWithError() throws {
        sut = nil
        
        try super.tearDownWithError()
    }

    @MainActor
    func testInitialValues() {
        // Given
        
        // When
        
        // Then
        XCTAssertEqual(sut.repositories, [])
        XCTAssertEqual(sut.uiState, .idle)
        XCTAssertEqual(sut.canRefresh, true)
    }
    
    @MainActor
    func testFetchRepositoriesSuccess() async {
        // Given
        UserDefaults.standard.setValue("testUser", forKey: "GITHUB_USERNAME")
        
        // When
        await sut.fetchRepositories()
        
        // Then
        XCTAssertNotEqual(sut.repositories.count, 0)
        XCTAssertEqual(sut.repositories.count, 10)
    }

}

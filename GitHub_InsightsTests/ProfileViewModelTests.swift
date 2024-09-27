//
//  ProfileViewModelTests.swift
//  GitHub_InsightsTests
//
//  Created by Brian Moyou on 27.09.24.
//

import XCTest
@testable import GitHub_Insights

final class ProfileViewModelTests: XCTestCase {
    private var sut: ProfileViewModel!
    private var repository: MockProfileRepository!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        repository = MockProfileRepository.shared
        repository.shouldFail = false
        sut = ProfileViewModel(repository: repository)
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
        XCTAssertEqual(sut.user, .EMPTY_USER)
        XCTAssertEqual(sut.uiState, .idle)
        XCTAssertEqual(sut.showLogOutSheet, false)
    }
    
    func testFetchUserSuccess() async {
        // Given
        UserDefaults.standard.setValue("testUser", forKey: "GITHUB_USERNAME")
        
        // When
        await sut.getUser()
        
        // Then
        XCTAssertEqual(sut.user, .MOCK_USER)
        XCTAssertEqual(sut.uiState, .idle)
    }
    
    // Should Never happen
    func testFetchUserWithoutUsername() async {
        // Given
        // GitHub username is not set in UserDefaults
        
        // When
        await sut.getUser()
        
        // Then
        XCTAssertEqual(sut.user, .EMPTY_USER)
        XCTAssertEqual(sut.uiState, .idle)
        XCTAssertTrue(ToastManager.shared.toast?.style == .error)
        XCTAssertEqual(ToastManager.shared.toast?.message, "No user found.")
    }
    
    func testFetchRepositoriesFailure() async {
        // Given
        UserDefaults.standard.setValue("testUser", forKey: "GITHUB_USERNAME")
        
        // When
        repository.shouldFail = true
        await sut.getUser()
        
        // Then
        XCTAssertEqual(sut.user, .EMPTY_USER)
        XCTAssertEqual(sut.uiState, .idle)
        XCTAssertTrue(ToastManager.shared.toast?.style == .error)
        XCTAssertEqual(ToastManager.shared.toast?.message, "No user found.")
    }
    
}

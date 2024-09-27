//
//  AuthViewModelTests.swift
//  GitHub_InsightsTests
//
//  Created by Brian Moyou on 27.09.24.
//

import XCTest
@testable import GitHub_Insights

final class AuthViewModelTests: XCTestCase {
    
    private var sut: AuthViewModel!
    private var repository: MockAuthRepository!
    
    override func setUp() {
        super.setUp()
        
        repository = MockAuthRepository.shared
        repository.shouldFail = false
        sut = AuthViewModel(repository: repository)
        UserDefaults.standard.removeObject(forKey: "GITHUB_USERNAME")
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
    func testInitialValues() {
        // Given
        
        // When
        
        // Then
        XCTAssertEqual(sut.username, "")
        XCTAssertEqual(sut.launchState, .launch)
    }
    
    func testCheckAuthWithNoUsername() async {
        // Given
        
        // When
        await sut.checkAuth()
        
        // Then
        XCTAssertEqual(sut.launchState, .auth, "Launch state should be `.auth` when no username is stored.")
    }
    
    func testCheckAuthSuccess() async {
        // Given
        UserDefaults.standard.set("testUser", forKey: "GITHUB_USERNAME")
        
        // When
        await sut.checkAuth()
        
        // Then
        XCTAssertEqual(sut.launchState, .session, "Launch state should be `.session` after successful authentication.")
    }
    
    func testCheckAuthFailure() async {
        // Given
        UserDefaults.standard.set("testUser", forKey: "GITHUB_USERNAME")
        repository.shouldFail = true
        
        // When
        await sut.checkAuth()
        
        // Then
        XCTAssertEqual(sut.launchState, .auth, "Launch state should be `.auth` when authentication fails.")
    }
    
    func testAuthenticateSuccess() async {
        // Given
        sut.username = "testUser"
        
        // When
        await sut.authenticate()
        
        // Then
        XCTAssertEqual(sut.launchState, .session, "Launch state should be `.session` after successful authentication.")
    }
    
    func testAuthenticateFailureShowsErrorToast() async {
        // Given
        sut.username = "invalidUser"
        repository.shouldFail = true
        
        // When
        await sut.authenticate()
        
        // Then
        XCTAssertEqual(sut.launchState, .auth, "Launch state should remain `.auth` after authentication failure.")
    }
    
    func testSignOutSuccess() async {
        // Given
        UserDefaults.standard.set("testUser", forKey: "GITHUB_USERNAME")
        sut.launchState = .session
        
        // When
        sut.signOut()
        
        // Then
        XCTAssertNil(UserDefaults.standard.string(forKey: "GITHUB_USERNAME"), "Username should be cleared from UserDefaults after sign out.")
        XCTAssertEqual(sut.launchState, .auth, "Launch state should be `.auth` after sign out.")
    }
    
}

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
        // Given no username in UserDefaults
        
        // When checkAuth is called
        await sut.checkAuth()
        
        // Then the launchState should be `.auth`
        XCTAssertEqual(sut.launchState, .auth, "Launch state should be `.auth` when no username is stored.")
    }
    
    func testCheckAuthSuccess() async {
        // Given a stored username in UserDefaults
        UserDefaults.standard.set("testUser", forKey: "GITHUB_USERNAME")
        
        // When checkAuth is called
        await sut.checkAuth()
        
        // Then the launchState should be `.session`
        XCTAssertEqual(sut.launchState, .session, "Launch state should be `.session` after successful authentication.")
    }
    
    func testCheckAuthFailure() async {
        // Given a stored username and mock repository set to fail
        UserDefaults.standard.set("testUser", forKey: "GITHUB_USERNAME")
        repository.shouldFail = true
        
        // When checkAuth is called
        await sut.checkAuth()
        
        // Then the launchState should be `.auth` due to failure
        XCTAssertEqual(sut.launchState, .auth, "Launch state should be `.auth` when authentication fails.")
    }
    
    func testAuthenticateSuccess() async {
        // Given a valid username input
        sut.username = "testUser"
        
        // When authenticate is called
        await sut.authenticate()
        
        // Then the launchState should be `.session`
        XCTAssertEqual(sut.launchState, .session, "Launch state should be `.session` after successful authentication.")
    }
    
    func testAuthenticateFailureShowsErrorToast() async {
        // Given the mock repository is set to fail
        sut.username = "invalidUser"
        repository.shouldFail = true
        
        // When authenticate is called
        await sut.authenticate()
        
        // Then ToastManager should have been called (assuming you have a way to observe ToastManager or its effect)
        // You may need to use dependency injection or observer to track the creation of a toast.
        XCTAssertEqual(sut.launchState, .auth, "Launch state should remain `.auth` after authentication failure.")
    }
    
    func testSignOutSuccess() async {
        // Given a session (set username and state)
        UserDefaults.standard.set("testUser", forKey: "GITHUB_USERNAME")
        sut.launchState = .session
        
        // When signOut is called
        sut.signOut()
        
        // Then username should be removed from UserDefaults and launchState should be `.auth`
        XCTAssertNil(UserDefaults.standard.string(forKey: "GITHUB_USERNAME"), "Username should be cleared from UserDefaults after sign out.")
        XCTAssertEqual(sut.launchState, .auth, "Launch state should be `.auth` after sign out.")
    }
    
}

//
//  OrganizationsViewModelTests.swift
//  GitHub_InsightsTests
//
//  Created by Brian Moyou on 27.09.24.
//

import XCTest
@testable import GitHub_Insights

final class OrganizationsViewModelTests: XCTestCase {
    private var sut: OrganizationsViewModel!
    private var repository: MockProfileRepository!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        repository = MockProfileRepository.shared
        repository.shouldFail = false
        sut = OrganizationsViewModel(repository: repository)
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
        XCTAssertEqual(sut.organizations, [])
        XCTAssertEqual(sut.uiState, .idle)
        XCTAssertEqual(sut.canRefresh, true)
        XCTAssertEqual(sut.page, 1)
    }
    
    func testFetchRepositoriesSuccess() async throws {
        // Given
        UserDefaults.standard.setValue("testUser", forKey: "GITHUB_USERNAME")
        let allOrgs: [Organization] = try FileManager.loadJson(fileName: "Organizations")
        
        // When
        await sut.fetchOrganizations()
        
        // Then
        XCTAssertEqual(sut.organizations.count, 10)
        XCTAssertEqual(sut.organizations, Array(allOrgs.prefix(10)))
        XCTAssertEqual(sut.uiState, .idle)
        XCTAssertTrue(sut.canRefresh)
        XCTAssertEqual(sut.page, 2)
    }
    
    func testFetchRepositoriesPagination() async throws {
        // Given
        UserDefaults.standard.setValue("testUser", forKey: "GITHUB_USERNAME")
        let allOrgs: [Organization] = try FileManager.loadJson(fileName: "Organizations")
        
        await sut.fetchOrganizations()
        
        XCTAssertEqual(sut.organizations.count, 10)
        XCTAssertEqual(sut.organizations, Array(allOrgs.prefix(10)))
        XCTAssertEqual(sut.uiState, .idle)
        XCTAssertEqual(sut.page, 2)
        XCTAssertTrue(sut.canRefresh)
        
        await sut.fetchOrganizations()
        
        XCTAssertEqual(sut.organizations.count, 20)
        XCTAssertEqual(sut.organizations, Array(allOrgs.prefix(20)))
        XCTAssertEqual(sut.uiState, .idle)
        XCTAssertEqual(sut.page, 3)
        XCTAssertTrue(sut.canRefresh)
        
        await sut.fetchOrganizations()
        await sut.fetchOrganizations()
        await sut.fetchOrganizations()
        await sut.fetchOrganizations()
        await sut.fetchOrganizations()
        await sut.fetchOrganizations()
        
        XCTAssertEqual(sut.organizations.count, 50)
        XCTAssertEqual(sut.organizations, allOrgs)
        XCTAssertEqual(sut.uiState, .idle)
        XCTAssertEqual(sut.page, 6)
        XCTAssertFalse(sut.canRefresh)
    }
    
    func testFetchRepositoriesWithEmptyResult() async throws {
        // Given
        UserDefaults.standard.setValue("testUser", forKey: "GITHUB_USERNAME")
        
        // When
        sut.page = 6
        await sut.fetchOrganizations()
        
        // Then
        XCTAssertEqual(sut.organizations.count, 0)
        XCTAssertEqual(sut.organizations, [])
        XCTAssertEqual(sut.uiState, .idle)
        XCTAssertFalse(sut.canRefresh)
        XCTAssertEqual(sut.page, 6)
    }
    
    func testFetchRepositoriesWithoutUsername() async {
        // Given
        // GitHub username is not set in UserDefaults
        
        // When
        await sut.fetchOrganizations()
        
        // Then
        XCTAssertEqual(sut.organizations.count, 0)
        XCTAssertEqual(sut.uiState, .idle)
        XCTAssertEqual(sut.page, 1)
    }
    
    func testFetchRepositoriesFailure() async {
        // Given
        UserDefaults.standard.setValue("testUser", forKey: "GITHUB_USERNAME")
        
        // When
        repository.shouldFail = true
        await sut.fetchOrganizations()
        
        // Then
        XCTAssertEqual(sut.organizations.count, 0)
        XCTAssertEqual(sut.uiState, .idle)
        XCTAssertFalse(sut.canRefresh)
        XCTAssertEqual(sut.page, 1)
        XCTAssertTrue(ToastManager.shared.toast?.style == .error)
        XCTAssertEqual(ToastManager.shared.toast?.message, "No Organizations found.")
    }
    
}

//
//  HomeViewModelTests.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 15/12/2024.
//

import XCTest
@testable import Discogsmusicfinder

class HomeViewModelTests: XCTestCase {
    var viewModel: HomeViewModel!
    var searchRepositoryMock: SearchRepositoryMock!
    var imageRepositoryMock: ImageRepositoryMock!
    var errorHandler: GenericErrorHandler!

    override func setUp() {
        super.setUp()
        imageRepositoryMock = ImageRepositoryMock()
        errorHandler = GenericErrorHandler()
        searchRepositoryMock = SearchRepositoryMock()
        viewModel = HomeViewModel(searchRepository: searchRepositoryMock, imageManager: imageRepositoryMock, errorHandler: errorHandler)
    }

    override func tearDown() {
        viewModel = nil
        searchRepositoryMock = nil
        imageRepositoryMock = nil
        errorHandler = nil
        super.tearDown()
    }

    func test_fetchArtists_withSuccessResponse() async {
        await viewModel.fetchArtists(query: "Nickelback")
        
        XCTAssertFalse(viewModel.searchResults.isEmpty)
        XCTAssertEqual(viewModel.searchResults.first?.title, "A (26)")
        XCTAssertEqual(viewModel.lastQuery, "Nickelback")
        XCTAssertFalse(viewModel.loadingContent)
    }

    func test_fetchArtists_withFailureResponse() async {
        searchRepositoryMock.apiClient.error = .networkError("Network error")
        
        await viewModel.fetchArtists(query: "Nickelback")
        
        XCTAssertNotNil(viewModel.error)
        XCTAssertEqual(viewModel.lastQuery, "Nickelback")
        XCTAssertFalse(viewModel.loadingContent)
    }

    func test_loadMoreArtists_withSuccessResponse() async {
        await viewModel.loadMoreArtists(query: "Nickelback")
        
        XCTAssertFalse(viewModel.searchResults.isEmpty)
        XCTAssertEqual(viewModel.searchResults.first?.title, "A (26)")
        XCTAssertEqual(viewModel.lastQuery, "Nickelback")
        XCTAssertFalse(viewModel.loadingNextPage)
    }

    func test_loadMoreArtists_withFailureResponse() async {
        searchRepositoryMock.apiClient.error = .networkError("Network error")
        
        await viewModel.loadMoreArtists(query: "Nickelback")
        
        XCTAssertNotNil(viewModel.error)
        XCTAssertEqual(viewModel.lastQuery, "Nickelback")
        XCTAssertFalse(viewModel.loadingNextPage)
    }

    func test_RequestArtistIfNeeded_withNonEmptyQuery() async {
        await viewModel.requestArtistIfNeeded("Nickelback")
        
        XCTAssertFalse(viewModel.showEmptyState)
        XCTAssertFalse(viewModel.searchResults.isEmpty)
    }

    func test_requestArtistIfNeeded_withEmptyQuery() async {
        await viewModel.requestArtistIfNeeded("")
        
        XCTAssertTrue(viewModel.showEmptyState, "Empty state should be true when the query is empty")
    }

    func test_tryRecoverFromError_withRecoverableError() async {
        await viewModel.tryRecoverFromError(.recoverableError(title: "Error", description: "Test error", actionTitle: "Try again"))
        
        XCTAssertNil(viewModel.error)
        XCTAssertFalse(viewModel.searchResults.isEmpty)
    }

    func test_tryRecoverFromError_withNonRecoverableError() async {
        await viewModel.tryRecoverFromError(.nonRecoverableError(title: "Error", description: "Test error", actionTitle: "Try again"))
        
        XCTAssertNil(viewModel.error)
        XCTAssertTrue(viewModel.searchResults.isEmpty)
    }
}

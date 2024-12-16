//
//  AlbumsViewModelTests.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 15/12/2024.
//

import XCTest
@testable import Discogsmusicfinder

class AlbumsViewModelTests: XCTestCase {
    var viewModel: AlbumsListViewModel!
    var artistRepositoryMock: ArtistRepositoryMock!
    var imageRepositoryMock: ImageRepositoryMock!
    var errorHandler: GenericErrorHandler!

    override func setUp() {
        super.setUp()
        imageRepositoryMock = ImageRepositoryMock()
        errorHandler = GenericErrorHandler()
        artistRepositoryMock = ArtistRepositoryMock()
        viewModel = AlbumsListViewModel(artistID: 108713, imageManager: imageRepositoryMock, artistRepository: artistRepositoryMock, errorHandler: errorHandler)
    }

    override func tearDown() {
        viewModel = nil
        artistRepositoryMock = nil
        imageRepositoryMock = nil
        errorHandler = nil
        super.tearDown()
    }

    func test_fetchAlbums_success() async {
        await viewModel.fetchAlbums(sort: .year, sortOrder: .asc)

        XCTAssertNotNil(viewModel.albums)
        XCTAssertEqual(viewModel.albums?.count, 2)
        XCTAssertFalse(viewModel.loadingContent)
    }

    func test_fetchAlbums_failure() async {
        artistRepositoryMock = ArtistRepositoryMock(error: .networkError("Network error"))
        viewModel = AlbumsListViewModel(artistID: 108713, imageManager: imageRepositoryMock, artistRepository: artistRepositoryMock, errorHandler: errorHandler)

        await viewModel.fetchAlbums()

        XCTAssertNotNil(viewModel.error)
        XCTAssertFalse(viewModel.loadingContent)
    }

    func test_loadMoreAlbums_success() async {
        await viewModel.loadMoreAlbums()

        XCTAssertNotNil(viewModel.albums)
        XCTAssertEqual(viewModel.albums?.count, 2)
        XCTAssertFalse(viewModel.loadingNextPage)
    }

    func test_loadMoreAlbums_failure() async {
        artistRepositoryMock = ArtistRepositoryMock(error: .networkError("Network error"))
        viewModel = AlbumsListViewModel(artistID: 108713, imageManager: imageRepositoryMock, artistRepository: artistRepositoryMock, errorHandler: errorHandler)

        await viewModel.loadMoreAlbums()

        XCTAssertNotNil(viewModel.error)
        XCTAssertFalse(viewModel.loadingNextPage)
    }
}

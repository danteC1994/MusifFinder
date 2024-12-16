//
//  ArtistDetailsViewModelTests.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 15/12/2024.
//

import XCTest
@testable import Discogsmusicfinder

class ArtistDetailsViewModelTests: XCTestCase {
    var viewModel: ArtistDetailsViewModel!
    var artistRepositoryMock: ArtistRepositoryMock!
    var imageRepositoryMock: ImageRepositoryMock!
    var errorHandler: GenericErrorHandler!

    override func setUp() {
        super.setUp()
        imageRepositoryMock = ImageRepositoryMock()
        errorHandler = GenericErrorHandler()
        artistRepositoryMock = ArtistRepositoryMock()
        viewModel = ArtistDetailsViewModel(artistID: 108713, imageManager: imageRepositoryMock, artistRepository: artistRepositoryMock, errorHandler: errorHandler)
    }

    override func tearDown() {
        viewModel = nil
        artistRepositoryMock = nil
        imageRepositoryMock = nil
        errorHandler = nil
        super.tearDown()
    }

    func test_fetchArtist_success() async {
        await viewModel.fetchArtist()
        
        XCTAssertNotNil(viewModel.artist)
        XCTAssertEqual(viewModel.artist?.id, 37757)
        XCTAssertNil(viewModel.error)
    }

    func test_fetchArtist_failure() async {
        artistRepositoryMock = ArtistRepositoryMock(error: .networkError("Network error"))
        viewModel = ArtistDetailsViewModel(artistID: 108713, imageManager: imageRepositoryMock, artistRepository: artistRepositoryMock, errorHandler: errorHandler)

        await viewModel.fetchArtist()
        
        XCTAssertNotNil(viewModel.error)
    }
}

//
//  AlbumsViewModelTests.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 15/12/2024.
//

import XCTest
@testable import Discogsmusicfinder

class AlbumsViewModelTests: XCTestCase {
    var viewModel: AlbumsViewModel!
    var artistRepositoryMock: ArtistRepositoryMock!
    var imageRepositoryMock: ImageRepositoryMock!
    var errorHandler: GenericErrorHandler!

    override func setUp() {
        super.setUp()
        imageRepositoryMock = ImageRepositoryMock()
        errorHandler = GenericErrorHandler()
        artistRepositoryMock = ArtistRepositoryMock()
        viewModel = AlbumsViewModel(artistID: 108713, imageManager: imageRepositoryMock, artistRepository: artistRepositoryMock, errorHandler: errorHandler)
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
    }

    func test_fetchAlbums_failure() async {
        artistRepositoryMock = ArtistRepositoryMock(error: .networkError("Network error"))
        viewModel = AlbumsViewModel(artistID: 108713, imageManager: imageRepositoryMock, artistRepository: artistRepositoryMock, errorHandler: errorHandler)

        await viewModel.fetchAlbums()

        XCTAssertNotNil(viewModel.error)
    }

    func test_removeDuplicateAlbums() {
        let album1 = Album(id: 1, artist: "Artist", title: "Album One", year: 2020, resourceURL: "", role: "", mainRelease: 1, thumb: "", type: "")
        let album2 = Album(id: 1, artist: "Artist", title: "Album One", year: 2020, resourceURL: "", role: "", mainRelease: 2, thumb: "", type: "")
        let album3 = Album(id: 2, artist: "Artist", title: "Album Two", year: 2021, resourceURL: "", role: "", mainRelease: 3, thumb: "", type: "")

        let albumsInput = [album1, album2, album3]
        let uniqueAlbums = viewModel.removeDuplicateAlbums(albums: albumsInput)

        XCTAssertEqual(uniqueAlbums.count, 2)
        XCTAssertTrue(uniqueAlbums.contains(where: { $0.id == album1.id }))
        XCTAssertTrue(uniqueAlbums.contains(where: { $0.id == album3.id }))
    }
}

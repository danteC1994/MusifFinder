//
//  Array+ExtensionsTests.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 16/12/2024.
//

import XCTest
@testable import Discogsmusicfinder

final class ArrayTests: XCTestCase {
    func test_removeDuplicateItems() {
        let album1 = Album(id: 1, artist: "Artist", title: "Album One", year: 2020, resourceURL: "", role: "", mainRelease: 1, thumb: "", type: "")
        let album2 = Album(id: 1, artist: "Artist", title: "Album One", year: 2020, resourceURL: "", role: "", mainRelease: 2, thumb: "", type: "")
        let album3 = Album(id: 2, artist: "Artist", title: "Album Two", year: 2021, resourceURL: "", role: "", mainRelease: 3, thumb: "", type: "")

        let albumsInput = [album1, album2, album3]
        let uniqueAlbums = albumsInput.removeDuplicateItems()

        XCTAssertEqual(uniqueAlbums.count, 2)
        XCTAssertTrue(uniqueAlbums.contains(where: { $0.id == album1.id }))
        XCTAssertTrue(uniqueAlbums.contains(where: { $0.id == album3.id }))
    }
}

//
//  ImageRepositoryImplementationTests.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 16/12/2024.
//

import XCTest
import SwiftUI
@testable import Discogsmusicfinder

class ImageRepositoryImplementationTests: XCTestCase {
    var imageRepository: ImageRepositoryMock!

    override func setUp() {
        super.setUp()
        imageRepository = ImageRepositoryMock()
    }

    override func tearDown() {
        imageRepository = nil
        super.tearDown()
    }

    func test_fetchImage_returnsSystemImage() async {
        let image = await imageRepository.fetchImage(for: "https://example.com/thumb1.png")
        
        XCTAssertNotNil(image)
    }

    func test_fetchImage_returnsNilForUnknownURL() async {
        let image = await imageRepository.fetchImage(for: "https://unknown.url/thumb.png")
        
        XCTAssertNil(image)
    }

    func test_fetchImage_returnsDifferentSystemImages() async {
        let image1 = await imageRepository.fetchImage(for: "https://example.com/thumb1.png")
        let image2 = await imageRepository.fetchImage(for: "https://example.com/thumb2.png")
        
        XCTAssertNotNil(image1)
        XCTAssertNotNil(image2)
    }
}

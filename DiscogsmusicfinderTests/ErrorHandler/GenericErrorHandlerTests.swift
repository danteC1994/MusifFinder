//
//  GenericErrorHandlerTests.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 16/12/2024.
//

import XCTest
import Networking
@testable import Discogsmusicfinder

class GenericErrorHandlerTests: XCTestCase {
    var errorHandler: GenericErrorHandler!

    override func setUp() {
        super.setUp()
        errorHandler = GenericErrorHandler()
    }

    override func tearDown() {
        errorHandler = nil
        super.tearDown()
    }

    func test_handle_withInvalidURL() {
        let error: APIError = .invalidURL
        let uiError = errorHandler.handle(error: error)

        switch uiError {
        case .nonRecoverableError(let title, let description, let actionTitle):
            XCTAssertEqual(title, "Oops! Something went wrong.")
            XCTAssertEqual(description, "It seems we are having technical difficulties, try again later")
            XCTAssertEqual(actionTitle, "Go back")
        default:
            XCTFail("Expected nonRecoverableError for invalidURL")
        }
    }

    func test_handle_withNetworkError() {
        let errorMessage = "Network connection lost"
        let error: APIError = .networkError(errorMessage)
        let uiError = errorHandler.handle(error: error)

        switch uiError {
        case .recoverableError(let title, let description, let actionTitle):
            XCTAssertEqual(title, "Oops! Something went wrong.")
            XCTAssertEqual(description, errorMessage)
            XCTAssertEqual(actionTitle, "Try again")
        default:
            XCTFail("Expected recoverableError for networkError")
        }
    }

    func test_handle_withDecodingError() {
        let error: APIError = .decodingError(NSError(domain: "", code: 0, userInfo: nil))
        let uiError = errorHandler.handle(error: error)

        switch uiError {
        case .nonRecoverableError(let title, let description, let actionTitle):
            XCTAssertEqual(title, "Oops! Something went wrong.")
            XCTAssertEqual(description, "It seems we are having technical difficulties, try again later")
            XCTAssertEqual(actionTitle, "Go back")
        default:
            XCTFail("Expected nonRecoverableError for decodingError")
        }
    }

    func test_handle_withEncodingError() {
        let error: APIError = .encodingError(NSError(domain: "", code: 1, userInfo: nil))
        let uiError = errorHandler.handle(error: error)

        switch uiError {
        case .nonRecoverableError(let title, let description, let actionTitle):
            XCTAssertEqual(title, "Oops! Something went wrong.")
            XCTAssertEqual(description, "It seems we are having technical difficulties, try again later")
            XCTAssertEqual(actionTitle, "Go back")
        default:
            XCTFail("Expected nonRecoverableError for encodingError")
        }
    }

    func test_handle_withUnknownError() {
        let error: APIError = .unknownError
        let uiError = errorHandler.handle(error: error)

        switch uiError {
        case .nonRecoverableError(let title, let description, let actionTitle):
            XCTAssertEqual(title, "Oops! Something went wrong.")
            XCTAssertEqual(description, "It seems we are having technical difficulties, try again later")
            XCTAssertEqual(actionTitle, "Go back")
        default:
            XCTFail("Expected nonRecoverableError for unknownError")
        }
    }
}

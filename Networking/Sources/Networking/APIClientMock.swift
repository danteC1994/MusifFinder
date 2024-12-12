//
//  APIClientMock.swift
//  Networking
//
//  Created by dante canizo on 10/12/2024.
//

final class APIClientMock: APIClient {
    var shouldReturnError = false

    func get<T>(endpoint: Endpoint, queryItems: [String : String]?, headers: [String : String]?) async throws -> T where T : Decodable {
        guard !shouldReturnError else {
            throw APIError.networkError("Mock response error")
        }
        switch endpoint {
        case .search:
            fatalError("not supported")
        case let .paginatedEndpoint(nextResult):
            fatalError("not supported")
        case .artist(_):
            fatalError("not supported")
        case .artistReleases(_):
            fatalError("not supported")
        }
    }

    func post<T, U>(endpoint: Endpoint, body: U, queryItems: [String : String]?, headers: [String : String]?) async throws -> T where T : Decodable, U : Encodable {
        switch endpoint {
        case .search:
            fatalError("not supported")
        case .paginatedEndpoint(_):
            fatalError("not supported")
        case .artist(_):
            fatalError("not supported")
        case .artistReleases(_):
            fatalError("not supported")
        }
    }
}

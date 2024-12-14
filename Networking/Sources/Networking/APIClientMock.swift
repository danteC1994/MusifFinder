//
//  APIClientMock.swift
//  Networking
//
//  Created by dante canizo on 10/12/2024.
//

public final class APIClientMock: APIClient {
    public var response: Decodable?
    public var error: APIError?

    public func get<T>(endpoint: Endpoint, queryItems: [String : String]?, headers: [String : String]?) async throws -> T where T : Decodable {
        if let error {
            throw error
        }
        return response as! T
    }

    public func post<T, U>(endpoint: Endpoint, body: U, queryItems: [String : String]?, headers: [String : String]?) async throws -> T where T : Decodable, U : Encodable {
        if let error {
            throw error
        }
        return response as! T
    }
}

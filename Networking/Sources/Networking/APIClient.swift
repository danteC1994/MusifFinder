//
//  APIClient.swift
//  Networking
//
//  Created by dante canizo on 10/12/2024.
//

protocol APIClient {
    func get<T: Decodable>(endpoint: Endpoint, queryItems: [String: String]?, headers: [String: String]?) async throws -> T
    func post<T: Decodable, U: Encodable>(endpoint: Endpoint, body: U, queryItems: [String: String]?, headers: [String: String]?) async throws -> T
}

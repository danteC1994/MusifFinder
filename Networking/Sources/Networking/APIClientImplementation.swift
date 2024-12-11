//
//  APIClientImplementation.swift
//  Networking
//
//  Created by dante canizo on 10/12/2024.
//

import Foundation

public class APIClientImplementation: APIClient {
    private let baseURL: URL
    private let authorization: String
    private let userAgent: String

    public init(baseURL: URL, authorization: String? = nil, userAgent: String? = nil) {
        self.baseURL = baseURL
        self.authorization = authorization ?? "Discogs token=aroChhXXzTTJQRrjQghirwbxFpuWyPxEEDDjYbbf"
        self.userAgent = userAgent ?? "DiscogsMusicFinder/1.0 +http://www.discogsmusicfinder.com"
        ["Authorization": "Discogs token=aroChhXXzTTJQRrjQghirwbxFpuWyPxEEDDjYbbf", "User-Agent": "DiscogsMusicFinder/1.0 +http://www.discogsmusicfinder.com"]
    }

    private func buildURL(endpoint: Endpoint, queryItems: [String: String]?) -> URL? {
        if case let .paginatedEndpoint(string) = endpoint,
           let fullURL = endpoint.urlString.removingPercentEncoding,
           let components = URLComponents(string: fullURL)  {
             var newComponents = components
             if let queryItems = queryItems {
                 var existingQueryItems = newComponents.queryItems ?? []
                 for (key, value) in queryItems {
                     existingQueryItems.append(URLQueryItem(name: key, value: value))
                 }
                 newComponents.queryItems = existingQueryItems
             }
             return newComponents.url
        }
        guard var urlComponents = URLComponents(url: baseURL.appendingPathComponent(endpoint.urlString), resolvingAgainstBaseURL: false) else {
            return nil
        }
        if let queryItems = queryItems {
            urlComponents.queryItems = queryItems.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        return urlComponents.url
    }

    public func get<T: Decodable>(endpoint: Endpoint, queryItems: [String: String]? = nil, headers: [String: String]? = nil) async throws -> T {
        guard let url = buildURL(endpoint: endpoint, queryItems: queryItems) else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        var headers = headers ?? [:]
        headers["Authorization"] = authorization
        headers["User-Agent"] = userAgent
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        

        let (data, _) = try await URLSession.shared.data(for: request)

        do {
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            return decodedResponse
        } catch {
            throw APIError.decodingError(error)
        }
    }

    public func post<T: Decodable, U: Encodable>(endpoint: Endpoint, body: U, queryItems: [String: String]? = nil, headers: [String: String]? = ["Authorization": "Discogs token=aroChhXXzTTJQRrjQghirwbxFpuWyPxEEDDjYbbf", "User-Agent": "DiscogsMusicFinder/1.0 +http://www.discogsmusicfinder.com"]) async throws -> T {
        guard let url = buildURL(endpoint: endpoint, queryItems: queryItems) else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        var headers = headers ?? [:]
        headers["Authorization"] = authorization
        headers["User-Agent"] = userAgent
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }

        do {
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            throw APIError.encodingError(error)
        }

        let (data, _) = try await URLSession.shared.data(for: request)

        do {
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            return decodedResponse
        } catch {
            throw APIError.decodingError(error)
        }
    }
}


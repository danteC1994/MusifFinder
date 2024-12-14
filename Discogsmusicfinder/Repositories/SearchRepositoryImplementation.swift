//
//  SearchRepositoryImplementation.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 10/12/2024.
//

import Networking

final class SearchRepositoryImplementation: SearchRepository {
    private let apiClient: APIClient
    private var artists: [SearchResult] = []
    private var nextLink: String?

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func searchArtists(query: String, pageSize: Int) async throws -> [SearchResult] {
        var queryItems: [String: String] = ["q": query]
        queryItems["type"] = "artist"
        queryItems["per_page"] = "\(pageSize)"
        queryItems["page"] = "1"
        let response: SearchResponse = try await apiClient.get(endpoint: .search, queryItems: queryItems, headers: [:])
        self.artists = response.results
        self.nextLink = response.pagination.urls.next
        return artists
    }

    func loadNextPage(query: String, pageSize: Int) async throws -> [SearchResult] {
        guard let nextLink = nextLink else { throw APIError.invalidURL }

        var queryItems: [String: String] = ["q": query]
        queryItems["type"] = "artist"
        queryItems["per_page"] = "\(pageSize)"
        queryItems["page"] = "1"
        let response: SearchResponse = try await apiClient.get(endpoint: .paginatedEndpoint(nextLink), queryItems: [:], headers: [:])
        self.artists.append(contentsOf: response.results)
        self.nextLink = response.pagination.urls.next
        return artists
    }
}

//
//  SearchRepositoryImplementation.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 10/12/2024.
//

import Networking

final class SearchRepositoryImplementation: SearchRepository {
    private let apiClient: APIClient
    private var artists: [Artist] = []
    private var nextLink: String?

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func searchArtists(query: String) async throws -> [Artist] {
        var queryItems: [String: String] = ["q": query]
        queryItems["type"] = "artist"
        queryItems["per_page"] = "30"
        queryItems["page"] = "1"
        let response: ArtistSearchResponse = try await apiClient.get(endpoint: .search, queryItems: queryItems, headers: [:])
        self.artists.append(contentsOf: response.results)
        self.nextLink = response.pagination.urls.next
        return artists
    }

    func loadNextPage() async throws -> [Artist] {
        guard let nextLink = nextLink else { throw APIError.invalidURL }
        
        let response: ArtistSearchResponse = try await apiClient.get(endpoint: .paginatedEndpoint(nextLink), queryItems: [:], headers: [:])
        self.artists.append(contentsOf: response.results)
        self.nextLink = response.pagination.urls.next
        return artists
    }

    func updateNextPage(with stringURL: String?) {
        self.nextLink = stringURL
    }
}

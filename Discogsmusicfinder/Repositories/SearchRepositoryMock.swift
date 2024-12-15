//
//  SearchRepositoryMock.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 15/12/2024.
//

import Networking

final class SearchRepositoryMock: SearchRepository {
    let apiClient: APIClientMock

    init(error: APIError? = nil) {
        self.apiClient = APIClientMock()
        apiClient.error = error
        apiClient.response = SearchResultTestData.searchArtist()
    }
    func searchArtists(query: String, pageSize: Int) async throws -> [SearchResult] {
        apiClient.response = SearchResultTestData.searchArtist()
        let response: SearchResponse = try await apiClient.get(endpoint: .search, queryItems: nil, headers: nil)
        return response.results
    }
    
    func loadNextPage(query: String, pageSize: Int) async throws -> [SearchResult] {
        apiClient.response = SearchResultTestData.searchArtist()
        let response: SearchResponse = try await apiClient.get(endpoint: .search, queryItems: nil, headers: nil)
        return response.results
    }
}

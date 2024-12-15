//
//  ArtistRepositoryMock.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 15/12/2024.
//

import Networking

final class ArtistRepositoryMock: ArtistRepository {
    let apiClient: APIClientMock

    init(error: APIError? = nil) {
        self.apiClient = APIClientMock()
        apiClient.error = error
        apiClient.response = SearchResultTestData.searchArtist()
    }

    func fetchArtist(artistID: String) async throws -> Artist {
        return try await apiClient.get(endpoint: .artist(artistID), queryItems: nil, headers: nil)
    }
    
    func fetchAlbums(artistID: String, sort: String, sortOrder: String) async throws -> [Album] {
        return try await apiClient.get(endpoint: .artistReleases(artistID), queryItems: nil, headers: nil)
    }
}

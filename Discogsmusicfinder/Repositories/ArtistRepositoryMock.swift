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
    }

    func fetchArtist(artistID: String) async throws -> Artist {
        do {
            apiClient.response = ArtistTestData.getArtist()
            return try await apiClient.get(endpoint: .artist(artistID), queryItems: nil, headers: nil)
        } catch {
            throw error
        }
    }
    
    func fetchAlbums(artistID: String, sort: String, sortOrder: String) async throws -> [Album] {
        do {
            apiClient.response = AlbumTestData.getAlbums()
            let response: AlbumResponse = try await apiClient.get(endpoint: .artistReleases(artistID), queryItems: nil, headers: nil)
            return response.releases
        } catch {
            throw error
        }
    }
}

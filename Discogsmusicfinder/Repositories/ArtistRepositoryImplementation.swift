//
//  ArtistRepositoryImplementation.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 12/12/2024.
//

import Networking

final class ArtistRepositoryImplementation: ArtistRepository {
    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    func fetchArtist(artistID: String) async throws -> Artist {
        let artist: Artist = try await apiClient.get(endpoint: .artist(artistID), queryItems: nil, headers: nil)
        return artist
    }

    func fetchAlbums(artistID: String) async throws -> [Album] {
        let album: AlbumResponse = try await apiClient.get(endpoint: .artistReleases(artistID), queryItems: nil, headers: nil)
        return album.releases
    }
}

//
//  ArtistRepositoryImplementation.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 12/12/2024.
//

import Networking

final class ArtistRepositoryImplementation: ArtistRepository {
    private let apiClient: APIClient
    private var nextArtistLink: String?
    private var albums: [Album] = []

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    func fetchArtist(artistID: String) async throws -> Artist {
        let artist: Artist = try await apiClient.get(endpoint: .artist(artistID), queryItems: nil, headers: nil)
        return artist
    }

    func fetchAlbums(artistID: String, sort: String, sortOrder: String, pageSize: Int) async throws -> [Album] {
        var queryItems = [String: String]()
        queryItems["sort"] = sort
        queryItems["sort_order"] = sortOrder
        queryItems["per_page"] = "\(pageSize)"
        queryItems["page"] = "1"
        let response: AlbumResponse = try await apiClient.get(endpoint: .artistReleases(artistID), queryItems: queryItems, headers: nil)
        self.albums = response.releases
        self.nextArtistLink = response.pagination.urls.next
        
        return albums
    }

    func loadNextAlbumsPage() async throws -> [Album] {
        guard let nextArtistLink = nextArtistLink else { return albums }

        let response: AlbumResponse = try await apiClient.get(endpoint: .paginatedEndpoint(nextArtistLink), queryItems: [:], headers: nil)
        self.albums.append(contentsOf: response.releases)
        self.nextArtistLink = response.pagination.urls.next
        return albums
    }
}

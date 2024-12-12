//
//  ArtistRepository.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 12/12/2024.
//

protocol ArtistRepository {
    func fetchArtist(artistID: String) async throws -> Artist
}

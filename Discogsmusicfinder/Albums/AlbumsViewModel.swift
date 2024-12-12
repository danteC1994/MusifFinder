//
//  AlbumsViewModel.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 12/12/2024.
//

import SwiftUI

final class AlbumsViewModel: ObservableObject {
    @Published private(set) var albums: [Album]?
    private let imageRepository: ImageRepository
    private let artistRepository: ArtistRepository
    private let artistID: Int

    init(artistID: Int, imageRepository: ImageRepository, artistRepository: ArtistRepository) {
        self.imageRepository = imageRepository
        self.artistRepository = artistRepository
        self.artistID = artistID
    }

    func fetchAlbums(artistID: String? = nil) async {
        do {
            let albums = try await artistRepository.fetchAlbums(artistID: artistID ?? "\(self.artistID)")
            await MainActor.run {
                self.albums = albums
            }
        } catch {
            
        }
    }
}

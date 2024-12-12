//
//  ArtistDetailsViewModel.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 11/12/2024.
//

import SwiftUI

class ArtistDetailsViewModel: ObservableObject {
    @Published private(set) var artist: Artist?
    private(set) var imageRepository: ImageRepository
    private(set) var artistRepository: ArtistRepository
    private let artistID: Int

    init(artistID: Int, imageRepository: ImageRepository, artistRepository: ArtistRepository) {
        self.imageRepository = imageRepository
        self.artistRepository = artistRepository
        self.artistID = artistID
    }

    func fetchArtist(artistID: String? = nil) async {
        do {
            let artist = try await artistRepository.fetchArtist(artistID: artistID ?? "\(self.artistID)")
            await MainActor.run {
                self.artist = artist
            }
        } catch {
            
        }
    }
}

extension ArtistDetailsViewModel: AsyncImageFetcher {
    func fetchImage(for url: String) async -> Image? {
        await imageRepository.fetchImage(for: url)
    }
}

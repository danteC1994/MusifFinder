//
//  ArtistDetailsViewModel.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 11/12/2024.
//

import SwiftUI

class ArtistDetailsViewModel: ObservableObject {
    @Published private(set) var artist: Artist?
    private(set) var imageManager: AsyncImageFetcher
    private(set) var artistRepository: ArtistRepository
    private let artistID: Int

    init(artistID: Int, imageManager: AsyncImageFetcher, artistRepository: ArtistRepository) {
        self.imageManager = imageManager
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

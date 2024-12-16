//
//  ArtistDetailsViewModel.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 11/12/2024.
//

import SwiftUI
import Networking

class ArtistDetailsViewModel: ObservableObject {
    @Published private(set) var artist: Artist?
    @Published private(set) var error: UIError?
    private(set) var imageManager: ImageRepository
    private(set) var artistRepository: ArtistRepository
    private let errorHandler: ErrorHandler
    private let artistID: Int

    init(artistID: Int, imageManager: ImageRepository, artistRepository: ArtistRepository, errorHandler: ErrorHandler) {
        self.imageManager = imageManager
        self.artistRepository = artistRepository
        self.artistID = artistID
        self.errorHandler = errorHandler
    }

    @MainActor
    func fetchArtist(artistID: String? = nil) async {
        do {
            let artist = try await artistRepository.fetchArtist(artistID: artistID ?? "\(self.artistID)")
            self.artist = artist
            self.error = nil
        } catch {
            self.error = errorHandler.handle(error: error as? APIError ?? .unknownError)
        }
    }
}

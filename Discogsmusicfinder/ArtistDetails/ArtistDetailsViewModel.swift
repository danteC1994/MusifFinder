//
//  ArtistDetailsViewModel.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 11/12/2024.
//

import SwiftUI

class ArtistDetailsViewModel: ObservableObject {
    @Published private(set) var artist: Artist!
    private let imageRepository: ImageRepository

    init(artistID: Int, imageRepository: ImageRepository) {
        self.imageRepository = imageRepository
    }
}

extension ArtistDetailsViewModel: AsyncImageFetcher {
    func fetchImage(for url: String) async -> Image? {
        await imageRepository.fetchImage(for: url)
    }
}

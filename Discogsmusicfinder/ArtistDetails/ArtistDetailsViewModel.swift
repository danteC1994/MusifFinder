//
//  ArtistDetailsViewModel.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 11/12/2024.
//

import SwiftUI

class ArtistDetailsViewModel: ObservableObject {
    private let imageRepository: ImageRepository

    init(imageRepository: ImageRepository) {
        self.imageRepository = imageRepository
    }
}

extension ArtistDetailsViewModel: AsyncImageFetcher {
    func fetchImage(for url: String) async -> Image? {
        await imageRepository.fetchImage(for: url)
    }
}

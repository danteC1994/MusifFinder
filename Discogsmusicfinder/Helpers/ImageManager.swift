//
//  ImageManager.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 13/12/2024.
//

import SwiftUI

actor ImageManager: AsyncImageFetcher {
    private(set) var imageRepository: ImageRepository

    init(imageRepository: ImageRepository) {
        self.imageRepository = imageRepository
    }

    func fetchImage(for url: String) async -> Image? {
        await imageRepository.fetchImage(for: url)
    }
}

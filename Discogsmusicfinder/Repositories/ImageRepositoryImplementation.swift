//
//  ImageRepositoryImplementation.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 11/12/2024.
//

import SwiftUI

final class ImageRepositoryImplementation: ImageRepository {
    @Published var imageCache: [String: Image] = [:]

    func fetchImage(for url: String) async -> Image? {
        if let cachedImage = imageCache[url] {
            return cachedImage
        }

        guard let imageUrl = URL(string: url) else {
            return nil
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: imageUrl)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                return nil
            }
            if let uiImage = UIImage(data: data) {
                let image = Image(uiImage: uiImage)
                await MainActor.run {
                    imageCache[url] = image
                }
                return image
            }
        } catch {
            print("Error fetching image: \(error)")
        }

        return nil
    }
}

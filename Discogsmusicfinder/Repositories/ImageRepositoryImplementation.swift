//
//  ImageRepositoryImplementation.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 11/12/2024.
//

import SwiftUI

actor ImageRepositoryImplementation: ImageRepository {
    private(set) var imageCache: [String: Image] = [:] // Cache for storing images

    func fetchImage(for url: String) async -> Image? {
        if let cachedImage = imageCache[url] {
            return cachedImage
        }

        guard let imageUrl = URL(string: url) else {
            print("Invalid URL: \(url)")
            return nil
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: imageUrl)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                print("Failed to fetch image, HTTP status: \((response as? HTTPURLResponse)?.statusCode ?? -1)")
                return nil
            }

            if let uiImage = UIImage(data: data) {
                let image = Image(uiImage: uiImage)
                imageCache[url] = image
                return image
            } else {
                print("Data could not be converted to a UIImage.")
            }
        } catch {
            print("Error fetching image: \(error)")
        }

        return nil
    }
}

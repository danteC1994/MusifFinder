//
//  HomeViewModel.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 10/12/2024.
//
import SwiftUI

final class HomeViewModel: ObservableObject {
    @Published var artists = [Artist]()
    @Published var isLoading: Bool = false
    @Published var error: Bool = false
    @Published var imageCache: [String: Image] = [:]

    private let repository: SearchRepository

    init(repository: SearchRepository) {
        self.repository = repository
    }

    func fetchArtists(query: String) async {
        do {
            let artists = try await repository.searchArtists(query: query, pageSize: 30)
            await MainActor.run {
                self.artists = artists
            }
        } catch {
            await MainActor.run {
                self.error = true
                print("Error fetching artists: \(error)")
            }
        }
    }

    func loadMoreArtists(query: String) async {
        do {
            let artists = try await repository.loadNextPage(query: query, pageSize: 30)
            await MainActor.run {
                self.artists = artists
            }
        } catch {
            await MainActor.run {
                self.error = true
                print("Error fetching artists: \(error)")
            }
        }
    }

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

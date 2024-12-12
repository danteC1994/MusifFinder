//
//  HomeViewModel.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 10/12/2024.
//
import SwiftUI

final class HomeViewModel: ObservableObject {
    @Published var searchResults = [SearchResult]()
    @Published var isLoading: Bool = false
    @Published var error: Bool = false

    private let searchRepository: SearchRepository
    private(set) var imageRepository: ImageRepository

    init(searchRepository: SearchRepository, imageRepository: ImageRepository) {
        self.searchRepository = searchRepository
        self.imageRepository = imageRepository
    }

    func fetchArtists(query: String) async {
        do {
            let searchResults = try await searchRepository.searchArtists(query: query, pageSize: 30)
            await MainActor.run {
                self.searchResults = searchResults
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
            let searchResults = try await searchRepository.loadNextPage(query: query, pageSize: 30)
            await MainActor.run {
                self.searchResults = searchResults
            }
        } catch {
            await MainActor.run {
                self.error = true
                print("Error fetching artists: \(error)")
            }
        }
    }
}

extension HomeViewModel: AsyncImageFetcher {
    func fetchImage(for url: String) async -> Image? {
        await imageRepository.fetchImage(for: url)
    }
}

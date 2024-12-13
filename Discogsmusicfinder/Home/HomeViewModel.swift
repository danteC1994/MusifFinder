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
    private(set) var imageManager: AsyncImageFetcher

    init(searchRepository: SearchRepository, imageManager: AsyncImageFetcher) {
        self.searchRepository = searchRepository
        self.imageManager = imageManager
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

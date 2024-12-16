//
//  HomeViewModel.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 10/12/2024.
//

import Networking
import SwiftUI

final class HomeViewModel: ObservableObject {
    @Published var searchResults = [SearchResult]()
    @Published var isLoading: Bool = false
    @Published var showEmptyState: Bool = true
    @Published private(set) var error: UIError?
    private(set) var imageManager: ImageRepository
    private(set) var lastQuery: String = ""
    private let searchRepository: SearchRepository
    private let errorHandler: ErrorHandler

    init(searchRepository: SearchRepository, imageManager: ImageRepository, errorHandler: ErrorHandler) {
        self.searchRepository = searchRepository
        self.imageManager = imageManager
        self.errorHandler = errorHandler
    }

    @MainActor
    func fetchArtists(query: String) async {
        do {
            let searchResults = try await searchRepository.searchArtists(query: query, pageSize: 30)
            self.searchResults = searchResults
            self.error = nil
        } catch {
            self.error = errorHandler.handle(error: error as? APIError ?? .unknownError)
        }
        lastQuery = query
    }

    @MainActor
    func loadMoreArtists(query: String) async {
        do {
            let searchResults = try await searchRepository.loadNextPage(query: query, pageSize: 30)
            self.searchResults = searchResults
            self.error = nil
        } catch {
            self.error = errorHandler.handle(error: error as? APIError ?? .unknownError)
        }
        lastQuery = query
    }

    @MainActor
    func requestArtistIfNeeded(_ newSearchValue: String) async {
        if !newSearchValue.isEmpty {
            await fetchArtists(query: newSearchValue)
            showEmptyState = false
        } else {
            showEmptyState = true
        }
    }

    @MainActor
    func tryRecoverFromError(_ error: UIError?) async {
        switch error {
        case .recoverableError, .none:
            self.error = nil
            await self.fetchArtists(query: lastQuery)
        case .nonRecoverableError:
            self.searchResults = []
            self.error = nil
        }
    }
}

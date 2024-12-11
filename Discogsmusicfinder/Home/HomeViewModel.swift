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

    private let repository: SearchRepository

    init(repository: SearchRepository) {
        self.repository = repository
    }

    func fetchArtists(query: String) async {
        do {
            let artists = try await repository.searchArtists(query: query)
            await MainActor.run {
                self.artists = artists
            }
        } catch {
            self.error = true
            print("Error fetching artists: \(error)")
        }
    }

    func loadMoreSrtists() async {
        do {
            let artists = try await repository.loadNextPage()
            await MainActor.run {
                self.artists = artists
            }
        } catch {
            self.error = true
            print("Error fetching artists: \(error)")
        }
    }
}

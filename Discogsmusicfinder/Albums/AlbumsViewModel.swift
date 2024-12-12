//
//  AlbumsViewModel.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 12/12/2024.
//

import SwiftUI

final class AlbumsViewModel: ObservableObject {
    @Published private(set) var albums: [Album]?
    @Published var currentSort: SortField = .year
    
    private let imageRepository: ImageRepository
    private let artistRepository: ArtistRepository
    private let artistID: Int
    

    enum SortField: String {
        case year
        case title
        case format
    }

    enum SortOrder: String {
        case asc
        case desc
    }

    init(artistID: Int, imageRepository: ImageRepository, artistRepository: ArtistRepository) {
        self.imageRepository = imageRepository
        self.artistRepository = artistRepository
        self.artistID = artistID
    }

    func updateSort(sort: SortField) {
        self.currentSort = sort
    }

    func fetchAlbums(sort: SortField? = nil, sortOrder: SortOrder? = nil) async {
        do {
            let albums = try await artistRepository.fetchAlbums(artistID: "\(self.artistID)", sort: sort?.rawValue ?? currentSort.rawValue, sortOrder: sortOrder?.rawValue ?? SortOrder.desc.rawValue)
            await MainActor.run {
                self.albums = albums
            }
        } catch {
            print("Error fetching albums: \(error)")
        }
    }
}

extension AlbumsViewModel: AsyncImageFetcher {
    func fetchImage(for url: String) async -> Image? {
        await imageRepository.fetchImage(for: url)
    }
}

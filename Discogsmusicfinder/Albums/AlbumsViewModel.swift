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
    
    private let artistRepository: ArtistRepository
    private let artistID: Int
    private(set) var imageManager: ImageRepository
    

    enum SortField: String {
        case year
        case title
        case format
    }

    enum SortOrder: String {
        case asc
        case desc
    }

    init(artistID: Int, imageManager: ImageRepository, artistRepository: ArtistRepository) {
        self.imageManager = imageManager
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
                self.albums = removeDuplicateAlbums(albums: albums)
            }
        } catch {
            print("Error fetching albums: \(error)")
        }
    }

    func removeDuplicateAlbums(albums: [Album]) -> [Album] {
        var seen = Set<Int>()
        return albums.filter { album in
            if seen.contains(album.id) {
                return false
            } else {
                seen.insert(album.id)
                return true
            }
        }
    }
}

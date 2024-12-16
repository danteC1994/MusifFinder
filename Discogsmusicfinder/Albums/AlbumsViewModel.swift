//
//  AlbumsViewModel.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 12/12/2024.
//

import SwiftUI
import Networking

final class AlbumsViewModel: ObservableObject {
    @Published private(set) var albums: [Album]?
    @Published var currentSort: SortField = .year
    @Published private(set) var error: UIError?
    
    private let artistRepository: ArtistRepository
    private let artistID: Int
    private let errorHandler: ErrorHandler
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

    init(artistID: Int, imageManager: ImageRepository, artistRepository: ArtistRepository, errorHandler: ErrorHandler) {
        self.imageManager = imageManager
        self.artistRepository = artistRepository
        self.artistID = artistID
        self.errorHandler = errorHandler
    }

    func updateSort(sort: SortField) {
        self.currentSort = sort
    }

    @MainActor
    func fetchAlbums(sort: SortField? = nil, sortOrder: SortOrder? = nil) async {
        do {
            let albums = try await artistRepository.fetchAlbums(
                artistID: "\(self.artistID)",
                sort: sort?.rawValue ?? currentSort.rawValue,
                sortOrder: sortOrder?.rawValue ?? SortOrder.desc.rawValue
            )
            self.albums = removeDuplicateAlbums(albums: albums)
            self.error = nil
        } catch {
            self.error = errorHandler.handle(error: error as? APIError ?? .unknownError)
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

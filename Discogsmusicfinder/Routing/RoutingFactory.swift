//
//  RoutingFactory.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 15/12/2024.
//

import Networking
import SwiftUI

struct ViewFactory {
    enum Environment {
        case stage
        case production
    }

    private let imageRepository: ImageRepository
    private let apiClient: APIClient
    private let environment: Environment

    init(environment: Environment = .production) {
        self.environment = environment
        switch environment {
        case .stage:
            apiClient = APIClientMock()
            self.imageRepository = ImageRepositoryMock()
        case .production:
            apiClient = APIClientImplementation(baseURL: URL(filePath: "https://api.discogs.com"))
            self.imageRepository = ImageRepositoryImplementation()
        }
    }

    @ViewBuilder
    func createView(for route: Route) -> some View {
        switch route {
        case .homeView:
            makeHomeView()
        case .artistDetail(artistID: let artistID):
            makeArtistDetailsView(artistID: artistID)
        case .albumsList(artistID: let artistID):
            makeAlbumList(artistID: artistID)
        case .albumDetails(album: let album):
            makeAlbumDetails(album: album)
        }
    }
    
    func makeHomeView() -> HomeView {
        switch environment {
        case .stage:
            return HomeView(
                viewModel: .init(
                    searchRepository: SearchRepositoryMock(),
                    imageManager: imageRepository,
                    errorHandler: GenericErrorHandler()
                )
            )
        case .production:
            return HomeView(
                viewModel: .init(
                    searchRepository: SearchRepositoryImplementation(
                        apiClient: apiClient
                    ),
                    imageManager: imageRepository,
                    errorHandler: GenericErrorHandler()
                )
            )
        }
    }

    func makeArtistDetailsView(artistID: Int) -> ArtistDetailView  {
        switch environment {
        case .stage:
            ArtistDetailView(
                viewModel: .init(
                    artistID: artistID,
                    imageManager: imageRepository,
                    artistRepository: ArtistRepositoryMock(),
                    errorHandler: GenericErrorHandler()
                )
            )
        case .production:
            ArtistDetailView(
                viewModel: .init(
                    artistID: artistID,
                    imageManager: imageRepository,
                    artistRepository: ArtistRepositoryImplementation(apiClient: apiClient),
                    errorHandler: GenericErrorHandler()
                )
            )
        }
    }

    func makeAlbumList(artistID: Int) -> AlbumsListView {
        switch environment {
        case .stage:
            AlbumsListView(
                viewModel: .init(
                    artistID: artistID,
                    imageManager: imageRepository,
                    artistRepository: ArtistRepositoryMock(),
                    errorHandler: GenericErrorHandler()
                )
            )
        case .production:
            AlbumsListView(
                viewModel: .init(
                    artistID: artistID,
                    imageManager: imageRepository,
                    artistRepository: ArtistRepositoryImplementation(apiClient: apiClient),
                    errorHandler: GenericErrorHandler()
                )
            )
        }
    }

    func makeAlbumDetails(album: Album) -> AlbumDetailsView {
        AlbumDetailsView(album: album, imageManager: imageRepository)
    }
}

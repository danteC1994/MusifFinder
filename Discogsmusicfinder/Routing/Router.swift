//
//  MainCoordinator.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 12/12/2024.
//

import Networking
import SwiftUI

enum Route {
    case homeView
    case artistDetail(artistID: Int)
    case albumsList(artistID: Int)
    case albumDetails(album: Album)
}

class Router: ObservableObject {
    private var viewFactory: ViewFactory
    @Published var navigationStack: [Route] = []

    init(viewFactory: ViewFactory) {
        self.viewFactory = viewFactory
    }

    func push(route: Route) -> some View {
        Task {
            await MainActor.run {
                navigationStack.append(route)
            }
        }
        return viewFactory.createView(for: route, on: self)
    }

    func pop() {
        if !navigationStack.isEmpty {
            navigationStack.removeLast()
        }
    }
}

struct ViewFactory {
    enum Environment {
        case stage
        case production
    }

    private let imageRepository: ImageRepository
    private let imageManager: AsyncImageFetcher
    private let apiClient: APIClient
    private let environment: Environment

    init(environment: Environment = .production) {
        self.environment = environment
        switch environment {
        case .stage:
            apiClient = APIClientMock()
            self.imageRepository = ImageRepositoryMock()
            imageManager = ImageManager(imageRepository: imageRepository)
        case .production:
            apiClient = APIClientImplementation(baseURL: URL(filePath: "https://api.discogs.com"))
            self.imageRepository = ImageRepositoryImplementation()
            imageManager = ImageManager(imageRepository: imageRepository)
        }
    }

    @ViewBuilder
    func createView(for route: Route, on router: Router) -> some View {
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
                    imageManager: imageManager
                )
            )
        case .production:
            return HomeView(
                viewModel: .init(
                    searchRepository: SearchRepositoryImplementation(
                        apiClient: apiClient
                    ),
                    imageManager: imageManager
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
                    imageManager: imageManager,
                    artistRepository: ArtistRepositoryMock()
                )
            )
        case .production:
            ArtistDetailView(
                viewModel: .init(
                    artistID: artistID,
                    imageManager: imageManager,
                    artistRepository: ArtistRepositoryImplementation(apiClient: apiClient)
                )
            )
        }
    }

    func makeAlbumList(artistID: Int) -> AlbumsView {
        switch environment {
        case .stage:
            AlbumsView(
                viewModel: .init(
                    artistID: artistID,
                    imageManager: imageManager,
                    artistRepository: ArtistRepositoryMock()
                )
            )
        case .production:
            AlbumsView(
                viewModel: .init(
                    artistID: artistID,
                    imageManager: imageManager,
                    artistRepository: ArtistRepositoryImplementation(apiClient: apiClient)
                )
            )
        }
    }

    func makeAlbumDetails(album: Album) -> AlbumDetailsView {
        AlbumDetailsView(album: album, imageManager: imageManager)
    }
}

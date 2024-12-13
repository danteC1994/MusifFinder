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

    init(imageRepository: ImageRepository, environment: Environment = .production) {
        self.imageRepository = imageRepository
        imageManager = ImageManager(imageRepository: imageRepository)
        switch environment {
        case .stage:
            fatalError("Not implemented")
        case .production:
            apiClient = APIClientImplementation(baseURL: URL(filePath: "https://api.discogs.com"))
        }
    }

    @ViewBuilder
    func createView(for route: Route, on router: Router) -> some View {
        switch route {
        case .homeView:
            makeHomeView(router: router)
        case .artistDetail(artistID: let artistID):
            makeArtistDetailsView(router: router, artistID: artistID)
        case .albumsList(artistID: let artistID):
            makeAlbumList(router: router, artistID: artistID)
        case .albumDetails(album: let album):
            makeAlbumDetails(album: album)
        }
    }
    
    func makeHomeView(router: Router) -> HomeView {
        return HomeView(
            router: router,
            viewModel: .init(
                searchRepository: SearchRepositoryImplementation(
                    apiClient: apiClient
                ),
                imageManager: imageManager
            )
        )
    }

    func makeArtistDetailsView(router: Router, artistID: Int) -> ArtistDetailView  {
        ArtistDetailView(
            router: router,
            viewModel: .init(
                artistID: artistID,
                imageManager: imageManager,
                artistRepository: ArtistRepositoryImplementation(apiClient: apiClient)
            )
        )
    }

    func makeAlbumList(router: Router, artistID: Int) -> AlbumsView {
        AlbumsView(
            router: router,
            viewModel: .init(
                artistID: artistID,
                imageManager: imageManager,
                artistRepository: ArtistRepositoryImplementation(apiClient: apiClient)
            )
        )
    }

    func makeAlbumDetails(album: Album) -> AlbumDetailsView {
        AlbumDetailsView(album: album, imageManager: imageManager)
    }
}

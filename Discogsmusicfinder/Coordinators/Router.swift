//
//  MainCoordinator.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 12/12/2024.
//

import Networking
import SwiftUI

final class Router: ObservableObject {
    private var viewFactory = ViewFactory()
    @Published var currentView: AnyView?

    func showHomeView() {
        let homeView = viewFactory.makeHomeView(router: self)
        currentView = AnyView(homeView)
    }
}

struct ViewFactory {
    func makeHomeView(router: Router) -> HomeView {
        return HomeView(
            router: router,
            viewModel: .init(
                searchRepository: SearchRepositoryImplementation(
                    apiClient: APIClientImplementation(
                        baseURL: URL(
                            filePath: "https://api.discogs.com"
                        )
                    )
                ),
                imageRepository: ImageRepositoryImplementation()
            )
        )
    }
}

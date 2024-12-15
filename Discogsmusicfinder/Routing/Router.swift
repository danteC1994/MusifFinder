//
//  Router.swift
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

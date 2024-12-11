//
//  DiscogsmusicfinderApp.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 10/12/2024.
//

import SwiftUI
import Networking

@main
struct DiscogsmusicfinderApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: .init(repository: SearchRepositoryImplementation(apiClient: APIClientImplementation(baseURL: URL(filePath: "https://api.discogs.com")))))
        }
    }
}

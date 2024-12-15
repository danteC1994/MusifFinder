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
    @StateObject private var router = Router(viewFactory: .init(environment: .stage))

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                router.push(route: .homeView)
                    .environmentObject(router)
            }
        }
    }
}

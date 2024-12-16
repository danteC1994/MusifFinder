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
    @StateObject private var router = Router(viewFactory: .init(environment: .production))

    var body: some Scene {
        WindowGroup {
            #if DEBUG
            if ProcessInfo.processInfo.environment["XCInjectBundleInto"] != nil {
                EmptyView()
            } else {
                NavigationStack {
                    router.push(route: .homeView)
                        .environmentObject(router)
                }
            }
            #else
            NavigationStack {
                router.push(route: .homeView)
                    .environmentObject(router)
            }
            #endif
        }
    }
}

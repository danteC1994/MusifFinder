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
    @ObservedObject var router = Router()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if let homeView = router.currentView {
                    homeView
                } else {
                    ProgressView()
                        .onAppear {
                            router.showHomeView()
                        }
                }
            }
        }
    }
}

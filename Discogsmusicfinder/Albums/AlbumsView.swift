//
//  AlbumsView.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 12/12/2024.
//

import SwiftUI

struct AlbumsView: View {
    @StateObject var viewModel: AlbumsViewModel

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .task {
                await viewModel.fetchAlbums()
            }
    }
}

#Preview {
//    AlbumsView(artist: )
}

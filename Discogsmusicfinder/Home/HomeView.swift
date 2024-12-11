//
//  HomeView.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 10/12/2024.
//

import SwiftUI
import Networking

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    @State private var searchText = ""
    @State private var artists: [Artist] = []
    @State private var showEmptyState = true

    var body: some View {
        NavigationStack {
            VStack {
                if showEmptyState {
                    Text("Search for an artist")
                        .font(.headline)
                        .padding()
                } else {
                    List(viewModel.artists) { artist in
                        NavigationLink(destination: ArtistDetailView(artist: artist)) {
                            Text("navigate")
                        }
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Artist Name")
            .onChange(of: searchText) { newValue in
                if !newValue.isEmpty {
                    Task {
                        await viewModel.fetchArtists(query: newValue)
                    }
                } else {
                    artists = []
                    showEmptyState = true
                }
            }
            .navigationTitle("Discogs Music Finder")
        }
        .task {
            await viewModel.fetchArtists(query: "")
        }
    }
}

#Preview {
    HomeView(viewModel: .init(repository: SearchRepositoryImplementation(apiClient: APIClientImplementation(baseURL: URL(filePath: "")!))))
}

struct ArtistDetailView: View {
    let artist: Artist
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(artist.title)
                .font(.largeTitle)
            NavigationLink("View Albums", destination: AlbumsView(artist: artist))
        }
        .navigationTitle(artist.title)
    }
}

struct AlbumsView: View {
    let artist: Artist

    var body: some View {
        Text("")
    }
}

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
                    emptyState
                } else {
                    listView(viewModel.artists)
                }
            }
            .searchable(text: $searchText, prompt: "Artist Name")
            .onChange(of: searchText) { _, newValue in
                requestArtistIfNeeded(newValue)
            }
            .padding()
            .navigationTitle("Discogs Music Finder")
        }
    }

    private var emptyState: some View {
        VStack {
            Image(systemName: "magnifyingglass.circle.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(.gray)
                .frame(width: 100, height: 100)
                .padding()
            Text("Search for an artist")
                .font(.headline)
                .foregroundColor(.gray)
                .padding()
            Text("Use the search bar above to find artists by name.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
    }

    private func listView(_ artists: [Artist]) -> some View {
        List(viewModel.artists) { artist in
            NavigationLink(destination: ArtistDetailView(artist: artist)) {
                HStack {
                    AsyncImageView(url: URL(string: artist.thumb ?? "") , viewModel: viewModel)
                    VStack(alignment: .leading) {
                        Text(artist.title)
                            .font(.headline)
                            .foregroundColor(.primary)
                        Text(artist.type.capitalized)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.leading, 5)
                }
                .onAppear {
                    if artist.id == viewModel.artists.last?.id {
                        Task {
                            await viewModel.loadMoreArtists(query: searchText)
                        }
                    }
                }
            }
        }
    }

    private func requestArtistIfNeeded(_ newSearchValue: String) {
        if !newSearchValue.isEmpty {
            Task {
                await viewModel.fetchArtists(query: newSearchValue)
                showEmptyState = false
            }
        } else {
            artists = []
            showEmptyState = true
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

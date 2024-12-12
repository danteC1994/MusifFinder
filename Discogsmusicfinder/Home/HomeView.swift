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
        ScrollView {
            LazyVStack {
                ForEach(viewModel.artists) { artist in
                    NavigationLink(
                        destination: ArtistDetailView(
                            artist: artist,
                            artistViewModel: .init(imageRepository: viewModel.imageRepository)
                        )
                    ) {
                        artistCell(artist)
                    }
                    .onAppear {
                        if artist.id == viewModel.artists.last?.id {
                            Task {
                                await viewModel.loadMoreArtists(query: searchText)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .listRowInsets(EdgeInsets())
        }
    }

    private func artistCell(_ artist: Artist) -> some View {
        NavigationLink(destination: ArtistDetailView(artist: artist, artistViewModel: .init(imageRepository: ImageRepositoryImplementation()))) {
            HStack {
                artistRowImage(artist)
                    .clipShape(Circle())
                    .frame(width: 50, height: 50)
                artistRowDescription(artist)
                    .padding(.leading, 6)
                Spacer()
            }
            .padding(.all, 6)
            .background(RoundedRectangle(cornerRadius: 10)
                .fill(Color(UIColor.systemBackground))
                .shadow(radius: 2))

        }
    }

    private func artistRowImage(_ artist: Artist) -> some View {
        ZStack {
            AsyncImageView(url: URL(string: artist.thumb ?? ""), fetcher: viewModel)
        }
    }

    private func artistRowDescription(_ artist: Artist) -> some View {
        VStack(alignment: .leading) {
            Text(artist.title)
                .font(.headline)
                .foregroundColor(.primary)
            Text(artist.type.capitalized)
                .font(.subheadline)
                .foregroundColor(.secondary)
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
    HomeView(viewModel: .init(searchRepository: SearchRepositoryImplementation(apiClient: APIClientImplementation(baseURL: URL(filePath: "")!)), imageRepository: ImageRepositoryImplementation()))
}

struct AlbumsView: View {
    let artist: Artist

    var body: some View {
        Text("")
    }
}

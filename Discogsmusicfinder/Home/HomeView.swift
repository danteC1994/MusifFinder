//
//  HomeView.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 10/12/2024.
//

import SwiftUI
import Networking

struct HomeView: View {
    @ObservedObject var router: Router
    @StateObject var viewModel: HomeViewModel
    @State private var searchText = ""
    @State private var artists: [SearchResult] = []
    @State private var showEmptyState = true

    var body: some View {
        NavigationStack {
            VStack {
                if showEmptyState {
                    emptyState
                } else {
                    listView(viewModel.searchResults)
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

    private func listView(_ searchResults: [SearchResult]) -> some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.searchResults) { artist in
                    artistCell(artist)
                    .onAppear {
                        if artist.id == viewModel.searchResults.last?.id {
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

    private func artistCell(_ artist: SearchResult) -> some View {
        NavigationLink(
            destination: router.push(route: .artistDetail(artistID: artist.id))
        ) {
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

    private func artistRowImage(_ artist: SearchResult) -> some View {
        ZStack {
            AsyncImageView(url: URL(string: artist.thumb ?? ""), fetcher: viewModel.imageManager)
        }
    }

    private func artistRowDescription(_ artist: SearchResult) -> some View {
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
//    HomeView(router: Router(), viewModel: .init(searchRepository: SearchRepositoryImplementation(apiClient: APIClientImplementation(baseURL: URL(filePath: "")!)), imageManager: ImageManager(imageRepository: ImageRepositoryImplementation as! ImageRepository)))
}

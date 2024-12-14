//
//  HomeView.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 10/12/2024.
//

import SwiftUI
import Networking

struct HomeView: View {
    @EnvironmentObject var router: Router
    @StateObject var viewModel: HomeViewModel
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.showEmptyState {
                    emptyState
                } else {
                    listView(viewModel.searchResults)
                }
            }
            .searchable(text: $searchText, prompt: "Artist Name")
            .onChange(of: searchText) { _, newValue in
                Task {
                    await viewModel.requestArtistIfNeeded(newValue)
                }
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
            destination: router.push(
                route: .artistDetail(
                    artistID: artist.id
                )
            )
            .environmentObject(router)
        ) {
            GenericCellView(
                viewData: .init(
                    imageManager: viewModel.imageManager,
                    imageURLString: artist.thumb,
                    title: artist.title,
                    subtitle: artist.type.capitalized
                )
            )
        }
    }
}

#Preview {
//    HomeView(router: Router(), viewModel: .init(searchRepository: SearchRepositoryImplementation(apiClient: APIClientImplementation(baseURL: URL(filePath: "")!)), imageManager: ImageManager(imageRepository: ImageRepositoryImplementation as! ImageRepository)))
}

//
//  AlbumsView.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 12/12/2024.
//

import SwiftUI
import Networking

struct AlbumsView: View {
    @StateObject var viewModel: AlbumsViewModel
    @State private var selectedYear: String = ""
    @State private var selectedGenre: String = ""
    @State private var selectedLabel: String = ""
    
    var body: some View {
        VStack {
            filterSection

            if let albums = viewModel.albums {
                ScrollView {
                    LazyVStack {
                        ForEach(albums) { album in
                            HStack {
                                NavigationLink(destination: AlbumDetailsView(album: album, imageFetcher: viewModel)) {
                                    HStack {
                                        if let thumb = album.thumb {
                                            AsyncImageView(url: URL(string: thumb), fetcher: viewModel)
                                                .frame(width: 50, height: 50)
                                                .cornerRadius(5)
                                        }
                                        
                                        VStack(alignment: .leading) {
                                            Text(album.title)
                                                .font(.headline)
                                            Text("Released: \(album.year ?? 0)")
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                    .padding(.vertical, 5)
                                }
                                Spacer()
                            }
                            .padding(.horizontal)
                            Divider()
                        }
                    }
                }
                
            } else {
                Text("No albums found for this artist.")
                    .font(.headline)
                    .padding()
            }
        }
        .navigationTitle("Albums")
        .task {
            await viewModel.fetchAlbums()
        }
    }

    private var filterSection: some View {
        HStack {
            filterButton(sortType: .year)
            filterButton(sortType: .title)
            filterButton(sortType: .format)
            Spacer()
        }
        .padding()
    }

    private func filterButton(sortType: AlbumsViewModel.SortField) -> some View {
        Button(action: {
            viewModel.currentSort = sortType
            Task {
                await viewModel.fetchAlbums(sort: sortType, sortOrder: .desc)
            }
        }) {
            Text("\(sortType.rawValue.capitalized)")
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(viewModel.currentSort == sortType ? Color.blue.opacity(0.3) : Color.gray.opacity(0.2))
                .cornerRadius(20)
                .foregroundColor(.primary)
        }
    }
}

#Preview {
    NavigationStack {
        AlbumsView(viewModel: .init(artistID: 1435265, imageRepository: ImageRepositoryImplementation(), artistRepository: ArtistRepositoryImplementation(apiClient: APIClientImplementation(baseURL: URL(filePath: "https://api.discogs.com")))))
    }
}

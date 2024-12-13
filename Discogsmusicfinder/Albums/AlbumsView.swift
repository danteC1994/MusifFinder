//
//  AlbumsView.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 12/12/2024.
//

import SwiftUI
import Networking

struct AlbumsView: View {
    @EnvironmentObject var router: Router
    @StateObject var viewModel: AlbumsViewModel
    
    var body: some View {
        VStack {
            filterSection
            if let albums = viewModel.albums {
                albumList(albums)
                
            } else {
                emptyState
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

    private func albumList(_ albums: [Album]) -> some View {
        ScrollView {
            LazyVStack {
                ForEach(albums) { album in
                    HStack {
                        albumCell(album)
                    }
                    .padding(.horizontal)
                }
            }
            .listRowInsets(EdgeInsets())
        }
    }

    private func albumCell(_ album: Album) -> some View {
        NavigationLink(
            destination: router.push(
                route: .albumDetails(
                    album: album
                )
            )
        ) {
            GenericCellView(
                viewData: .init(
                    imageManager: viewModel.imageManager,
                    imageURLString: album.thumb,
                    title: album.title,
                    subtitle: "Released: \(album.year ?? 0)"
                )
            )
        }
    }

    private var emptyState: some View {
        Text("No albums found for this artist.")
            .font(.headline)
            .padding()
    }
}

#Preview {
//    NavigationStack {
//        AlbumsView(viewModel: .init(artistID: 1435265, imageRepository: ImageRepositoryImplementation(), artistRepository: ArtistRepositoryImplementation(apiClient: APIClientImplementation(baseURL: URL(filePath: "https://api.discogs.com")))))
//    }
}

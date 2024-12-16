//
//  AlbumsView.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 12/12/2024.
//

import SwiftUI
import Networking

struct AlbumsListView: View {
    @EnvironmentObject var router: Router
    @StateObject var viewModel: AlbumsListViewModel
    
    var body: some View {
        VStack {
            if viewModel.loadingContent {
                ProgressView()
            } else if let error = viewModel.error {
                errorView(error)
            } else {
                if let albums = viewModel.albums {
                    filterSection
                    albumList(albums)
                    if viewModel.loadingNextPage {
                        ProgressView()
                    }
                } else {
                    emptyState
                }
            }
        }
        .navigationTitle("Albums")
        .task {
            await viewModel.fetchAlbums()
        }
    }

    private func errorView(_ error: UIError) -> some View {
        switch error {
        case .recoverableError(title: let title, description: let description, actionTitle: let actionTitle):
            GenericErrorView(
                title: title,
                description: description,
                actionTitle: actionTitle,
                action: {
                    Task {
                        await viewModel.fetchAlbums()
                    }
                }
            )
        case .nonRecoverableError(title: let title, description: let description, actionTitle: let actionTitle):
            GenericErrorView(
                title: title,
                description: description,
                actionTitle: actionTitle,
                action: {
                    router.pop()
                }
            )
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

    private func filterButton(sortType: AlbumsListViewModel.SortField) -> some View {
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
                            .onAppear {
                                if album.id == viewModel.albums?.last?.id {
                                    Task {
                                        await viewModel.loadMoreAlbums()
                                    }
                                }
                            }
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
    let router = Router(
        viewFactory: .init(
            environment: .stage
        )
    )
    NavigationStack {
        router.push(route: .albumsList(artistID: 12345))
    }
    .environmentObject(router)
}

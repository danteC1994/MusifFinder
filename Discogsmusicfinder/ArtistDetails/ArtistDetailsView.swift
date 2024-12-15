//
//  ArtistDetailsView.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 11/12/2024.
//

import SwiftUI

struct ArtistDetailView: View {
    @EnvironmentObject var router: Router
    @StateObject var viewModel: ArtistDetailsViewModel

    var body: some View {
         if let artist = viewModel.artist {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Text(artist.namevariations?.first ?? artist.profile)
                        .font(.largeTitle)
                        .padding(.vertical)
                    
                    if let primaryImage = artist.images.first(where: { $0.type == "primary" }) {
                        AsyncImageView(url: URL(string: primaryImage.uri), fetcher: viewModel.imageManager)
                    }
                    
                    Text(artist.profile)
                        .font(.body)
                        .padding(.bottom)
                    
                    NavigationLink(
                        "View Albums",
                        destination: router.push(
                            route: .albumsList(
                                artistID: artist.id
                            )
                        )
                        .environmentObject(router)
                    )
                    .font(.headline)
                    .padding(.bottom)
                    
                    if let members = viewModel.artist?.members {
                        Text("Band Members")
                            .font(.title2)
                            .padding(.vertical)
                        
                        ForEach(members, id: \.id) { member in
                            HStack {
                                NavigationLink(
                                    destination: router.push(
                                        route: .artistDetail(
                                            artistID: member.id
                                        )
                                    )
                                    .environmentObject(router)
                                ) {
                                    Text(member.name)
                                        .font(.headline)
                                        .padding(.vertical, 5)
                                }
                            }
                        }
                    }
                    
                    if let urls = artist.urls, !urls.isEmpty {
                        Text("More Information:")
                            .font(.title2)
                            .padding(.vertical)
                        
                        ForEach(urls, id: \.self) { urlString in
                            if let url = URL(string: urlString) {
                                Link(urlString, destination: url)
                                    .padding(.vertical, 5)
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle(artist.namevariations?.first ?? artist.profile)
        } else {
            ProgressView()
                .frame(width: 50, height: 50)
                .task {
                    await viewModel.fetchArtist()
                }
        }
    }
}

#Preview {
    let router = Router(
        viewFactory: .init(
            environment: .stage
        )
    )
    NavigationStack {
        router.push(route: .artistDetail(artistID: 12345))
    }
    .environmentObject(router)
}

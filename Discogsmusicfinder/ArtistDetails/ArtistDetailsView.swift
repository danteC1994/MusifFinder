//
//  ArtistDetailsView.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 11/12/2024.
//

import SwiftUI

struct ArtistDetailView: View {
    @StateObject var viewModel: ArtistDetailsViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(viewModel.artist.namevariations?.first ?? viewModel.artist.profile)
                    .font(.largeTitle)
                    .padding(.vertical)

                if let primaryImage = viewModel.artist.images.first(where: { $0.type == "primary" }) {
                    AsyncImageView(url: URL(string: primaryImage.uri), fetcher: viewModel)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(height: 200)
//                        .cornerRadius(10)
//                        .padding(.bottom)
                }

                Text(viewModel.artist.profile)
                    .font(.body)
                    .padding(.bottom)

                NavigationLink("View Albums", destination: AlbumsView(artist: viewModel.artist))
                    .font(.headline)
                    .padding(.bottom)

                if hasBandMembers {
                    Text("Band Members")
                        .font(.title2)
                        .padding(.vertical)

                    ForEach(viewModel.artist.members, id: \.id) { member in
//                        HStack {
//                            NavigationLink(destination: ArtistDetailView(artist: member)) {
//                                Text(member.name)
//                                    .font(.headline)
//                                    .padding(.vertical, 5)
//                            }
//                        }
                    }
                }

                if !viewModel.artist.urls.isEmpty {
                    Text("More Information:")
                        .font(.title2)
                        .padding(.vertical)

                    ForEach(viewModel.artist.urls, id: \.self) { url in
                        Link(url, destination: URL(string: url)!)
                            .padding(.vertical, 5)
                            .font(.subheadline)
                            .foregroundColor(.blue)
                    }
                }
            }
            .padding()
        }
        .navigationTitle(viewModel.artist.namevariations?.first ?? viewModel.artist.profile)
    }
    
    private var hasBandMembers: Bool {
        return !viewModel.artist.members.isEmpty
    }
}

//#Preview {
//    ArtistDetailsView(artist: .init(id: 123, type: "artist", userData: .init(inWantlist: false, inCollection: false), uri: "https", title: "Title", thumb: "imageURL", coverImage: "ImageCover", resourceURL: ""), coverImage: nil)
//}

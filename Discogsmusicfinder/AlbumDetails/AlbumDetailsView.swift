//
//  AlbumDetailsView.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 12/12/2024.
//

import SwiftUI

struct AlbumDetailsView: View {
    let album: Album
    let imageManager: ImageRepository

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(album.title)
                    .font(.largeTitle)
                    .padding(.vertical)

                Text("Artist: \(album.artist)")
                    .font(.title2)
                    .padding(.bottom)

                if let thumb = album.thumb,let  coverImageUrl = URL(string: thumb), !thumb.isEmpty {
                    AsyncImageView(url: coverImageUrl, fetcher: imageManager)
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .cornerRadius(10)
                        .padding(.bottom)
                        .foregroundColor(.gray)
                }

                if let albumYear = album.year {
                    Text("Release Year: \(albumYear)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.bottom)
                }

                Text("Tracklist")
                    .font(.title2)
                    .padding(.top)

//                ForEach(album.tracks, id: \.id) { track in
//                    HStack {
//                        Text(track.title)
//                        Spacer()
//                        Text(track.duration)
//                            .font(.caption)
//                            .foregroundColor(.secondary)
//                    }
//                    .padding(.vertical, 2)
//                }
            }
            .padding()
        }
        .navigationTitle(album.title)
    }
}




#Preview {
    let router = Router(
        viewFactory: .init(
            environment: .stage
        )
    )
    NavigationStack {
        router.push(route: .albumDetails(album: AlbumTestData.getAlbums().releases.first!))
    }
    .environmentObject(router)
}

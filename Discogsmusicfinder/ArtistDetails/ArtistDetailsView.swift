//
//  ArtistDetailsView.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 11/12/2024.
//

import SwiftUI

struct ArtistDetailView: View {
    let artist: Artist
    @StateObject var artistViewModel: ArtistDetailsViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                // Artist title
                Text(artist.title)
                    .font(.largeTitle)
                    .padding(.vertical)

                // Display cover image if available
                if let coverImageURL = URL(string: artist.coverImage), !artist.coverImage.isEmpty {
                    AsyncImageView(url: coverImageURL, fetcher: artistViewModel) // Passing the URL and view model
                        
                        .scaledToFit()
                        .frame(height: 200)
                        .cornerRadius(10)
                        .padding(.bottom) // Adding some space below the image
                }

                // Navigation link to albums
                NavigationLink("View Albums", destination: AlbumsView(artist: artist))
                    .font(.headline)
                    .padding(.bottom)

                // Check if the artist has members (for bands)
                if hasBandMembers {
                    Text("Band Members")
                        .font(.title2)
                        .padding(.vertical)

                    // Show band members here
                    ForEach(bandMembers, id: \.id) { member in
                        Text(member.title) // Display the name of each band member
                            .font(.headline)
                            .padding(.vertical, 5)
                    }
                }

                // Additional information section (if any)
                Text("Artist Type: \(artist.type.capitalized)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                // Example additional detail
                Text("URI: \(artist.uri)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding()
        }
        .navigationTitle(artist.title) // Title set to artist's name
    }

    // Check if the artist is a band
    private var hasBandMembers: Bool {
        return artist.type.lowercased() == "band" // Adjust based on your logic
    }

    // Placeholder for getting band members, adjust according to your data source
    private var bandMembers: [Artist] {
        // This is a placeholder; replace with actual logic to retrieve band members if the artist is a band
        return [
            Artist(id: 1, type: "member", userData: UserData(inWantlist: false, inCollection: false), uri: "", title: "Member 1", thumb: "", coverImage: "", resourceURL: ""),
            Artist(id: 2, type: "member", userData: UserData(inWantlist: false, inCollection: false), uri: "", title: "Member 2", thumb: "", coverImage: "", resourceURL: "")
        ]
    }
}

//#Preview {
//    ArtistDetailsView(artist: .init(id: 123, type: "artist", userData: .init(inWantlist: false, inCollection: false), uri: "https", title: "Title", thumb: "imageURL", coverImage: "ImageCover", resourceURL: ""), coverImage: nil)
//}

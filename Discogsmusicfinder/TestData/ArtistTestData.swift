//
//  ArtistTestData.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 13/12/2024.
//

final class ArtistTestData {
    func getArtist() -> Artist {
        let images = [
            ArtistImage(
                height: 300,
                resourceURL: "https://i.discogs.com/PIj7YL2KNMtqkXKS_XEurIBEpUCb7M1QlfPs7MpFPrk/rs:fit/g:sm/q:90/h:300/w:475/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTM3NzU3/LTE0NDczMjQ1NjEt/NDYwNy5qcGVn.jpeg",
                type: "primary",
                uri: "https://i.discogs.com/PIj7YL2KNMtqkXKS_XEurIBEpUCb7M1QlfPs7MpFPrk/rs:fit/g:sm/q:90/h:300/w:475/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTM3NzU3/LTE0NDczMjQ1NjEt/NDYwNy5qcGVn.jpeg",
                uri150: "https://i.discogs.com/FqMwEC29A1rbf8MiV1dwnsNb_N0JKVpXBKgEqclAgQk/rs:fit/g:sm/q:40/h:150/w:150/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTM3NzU3/LTE0NDczMjQ1NjEt/NDYwNy5qcGVn.jpeg",
                width: 475
            )
        ]

        let members = [
            Member(id: 147679, name: "Magne Furuholmen", resourceURL: "https://api.discogs.com/artists/147679", active: true),
            Member(id: 333419, name: "Morten Harket", resourceURL: "https://api.discogs.com/artists/333419", active: true),
            Member(id: 634036, name: "Paul Waaktaar-Savoy", resourceURL: "https://api.discogs.com/artists/634036", active: true)
        ]

        return Artist(
            id: 37757,
            namevariations: ["A - HA", "A - Ha", "A HA", "A Ha", "A ha"],
            profile: """
            Norwegian band formed in Oslo in 1982. The band split in 2010 after a worldwide tour of 73 shows.
            In December 2014 they announced they would participate in the "Rock in Rio" festival for September 2015.
            In March 2015 they announced a comeback album "Cast In Steel" that was released September of that year.
            The first single from that album "Under The Makeup" was released in July 2015.
            They continue to record and tour.
            Morten Harket (born September 14th, 1959): vocals
            Paul Waaktaar-Savoy (born September 6th, 1961): guitar, vocals
            Magne Furuholmen (born November 1st, 1962): keyboards, vocals
            """,
            releasesURL: "https://api.discogs.com/artists/37757/releases",
            resourceURL: "https://api.discogs.com/artists/37757",
            uri: "https://www.discogs.com/artist/37757-a-ha",
            urls: ["http://www.a-ha.com", "http://a-ha-live.com", "http://www.discog.info/a-ha.html"],
            dataQuality: "Needs Vote",
            images: images,
            members: members
        )
    }
}

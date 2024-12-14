//
//  AlbumTestData.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 13/12/2024.
//

final class AlbumTestData {
    func getArtist() -> Album {
        Album(
            id: 173765,
            artist: "Nickelback",
            title: "Curb",
            year: 1996,
            resourceURL: "http://api.discogs.com/masters/173765",
            role: "Main",
            mainRelease: 3128432,
            thumb: "https://api-img.discogs.com/lb0zp7--FLaRP0LmJ4W6DhfweNc=/fit-in/90x90/filters:strip_icc():format(jpeg):mode_rgb()/discogs-images/R-5557864-1396493975-7618.jpeg.jpg",
            type: "master"
        )
    }
}

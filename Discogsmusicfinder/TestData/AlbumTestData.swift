//
//  AlbumTestData.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 13/12/2024.
//

final class AlbumTestData {
    static func getAlbums() -> AlbumResponse {
        let releases = [
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
            ),
            Album(
                id: 1737656,
                artist: "Nickelback2",
                title: "Curb2",
                year: 1996,
                resourceURL: "http://api.discogs.com/masters/173765",
                role: "Main",
                mainRelease: 31284322,
                thumb: "https://api-img.discogs.com/lb0zp7--FLaRP0LmJ4W6DhfweNc=/fit-in/90x90/filters:strip_icc():format(jpeg):mode_rgb()/discogs-images/R-5557864-1396493975-7618.jpeg.jpg",
                type: "master"
            )
        ]
        
        let pagination = Pagination(
            page: 1,
            pages: 3333,
            perPage: 3,
            items: 411311,
            urls: PaginationURLs(
                last: "https://api.discogs.com/database/search?q=a&type=artist&per_page=3&page=3333",
                next: "https://api.discogs.com/database/search?q=a&type=artist&per_page=3&page=2"
            )
        )

        return AlbumResponse(pagination: pagination, releases: releases)
    }
}

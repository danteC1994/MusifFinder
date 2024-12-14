//
//  SearchResultTestData.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 13/12/2024.
//

final class SearchResultTestData {
    func getArtist() -> SearchResponse {
        let results = [
            SearchResult(
                id: 3182820,
                type: "artist",
                userData: UserData(inWantlist: false, inCollection: false),
                uri: "/artist/3182820-A-26",
                title: "A (26)",
                thumb: "",
                coverImage: "https://st.discogs.com/151842c5796ee88804601ddb1db90d9cee6b52d5/images/spacer.gif",
                resourceURL: "https://api.discogs.com/artists/3182820"
            ),
            SearchResult(
                id: 72848,
                type: "artist",
                userData: UserData(inWantlist: false, inCollection: false),
                uri: "/artist/72848-A",
                title: "A",
                thumb: "https://i.discogs.com/JjHlJPT4Y-hixjX6ptxS4KJ_EZkqUlQGhqvLJNtMg9I/rs:fit/g:sm/q:40/h:150/w:150/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTcyODQ4/LTE3MDg2NDkwNzAt/NTI3Ny5qcGVn.jpeg",
                coverImage: "https://i.discogs.com/CKYpoR6pBiS7MyS3dlc4a-M97ELGOX6Qcjg9ZH7krAE/rs:fit/g:sm/q:90/h:331/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9BLTcyODQ4/LTE3MDg2NDkwNzAt/NTI3Ny5qcGVn.jpeg",
                resourceURL: "https://api.discogs.com/artists/72848"
            ),
            SearchResult(
                id: 1853214,
                type: "artist",
                userData: UserData(inWantlist: false, inCollection: false),
                uri: "/artist/1853214-Å-2",
                title: "Å (2)",
                thumb: "",
                coverImage: "https://st.discogs.com/151842c5796ee88804601ddb1db90d9cee6b52d5/images/spacer.gif",
                resourceURL: "https://api.discogs.com/artists/1853214"
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

        return SearchResponse(pagination: pagination, results: results)
    }
}

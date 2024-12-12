//
//  Album.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 12/12/2024.
//

struct AlbumResponse: Codable {
    let pagination: Pagination
    let releases: [Album]

    struct Pagination: Codable {
        let perPage: Int
        let items: Int
        let page: Int
        let pages: Int
        let urls: [String: String]

        enum CodingKeys: String, CodingKey {
            case perPage = "per_page"
            case items, page, pages, urls
        }
    }
}

struct Album: Codable, Identifiable {
    let id: Int
    let artist: String
    let title: String
    let year: Int?
    let resourceURL: String
    let role: String
    let mainRelease: Int?
    let thumb: String?
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case id, artist, title, year, resourceURL = "resource_url", role, mainRelease = "main_release", thumb, type
    }
}

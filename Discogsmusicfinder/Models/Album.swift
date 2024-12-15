//
//  Album.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 12/12/2024.
//

struct AlbumResponse: Codable {
    let pagination: Pagination
    let releases: [Album]
}

struct Album: Codable, Identifiable, Hashable {
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

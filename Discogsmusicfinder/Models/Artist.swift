//
//  Artist.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 12/12/2024.
//

import Foundation

struct Artist: Codable, Identifiable {
    let id: Int
    let namevariations: [String]?
    let profile: String
    let releasesURL: String
    let resourceURL: String
    let uri: String
    let urls: [String]
    let dataQuality: String
    let images: [ArtistImage]
    let members: [Member]

    enum CodingKeys: String, CodingKey {
        case id
        case namevariations
        case profile
        case releasesURL = "releases_url"
        case resourceURL = "resource_url"
        case uri
        case urls
        case dataQuality = "data_quality"
        case images
        case members
    }
}

struct ArtistImage: Codable {
    let height: Int
    let resourceURL: String
    let type: String
    let uri: String
    let uri150: String
    let width: Int
}

struct Member: Codable, Identifiable {
    let id: Int
    let name: String
    let resourceURL: String
    let active: Bool
}

//
//  Artist.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 10/12/2024.
//

struct SearchResponse: Codable {
    let pagination: Pagination
    let results: [SearchResult]
}

struct PaginationURLs: Codable {
    let last: String?
    let next: String?
}

struct SearchResult: Codable, Identifiable {
    let id: Int
    let type: String
    let userData: UserData
    let uri: String
    let title: String
    let thumb: String?
    let coverImage: String
    let resourceURL: String
    
    enum CodingKeys: String, CodingKey {
        case id, type, userData = "user_data", uri, title, thumb, coverImage = "cover_image", resourceURL = "resource_url"
    }
}

struct UserData: Codable {
    let inWantlist: Bool
    let inCollection: Bool
    
    enum CodingKeys: String, CodingKey {
        case inWantlist = "in_wantlist"
        case inCollection = "in_collection"
    }
}

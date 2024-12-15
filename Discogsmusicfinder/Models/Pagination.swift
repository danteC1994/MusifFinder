//
//  Pagination.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 15/12/2024.
//

struct Pagination: Codable {
    let page: Int
    let pages: Int
    let perPage: Int
    let items: Int
    let urls: PaginationURLs

    enum CodingKeys: String, CodingKey {
        case page, pages, perPage = "per_page", items, urls
    }
}

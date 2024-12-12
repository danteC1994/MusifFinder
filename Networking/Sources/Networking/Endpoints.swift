//
//  Endpoints.swift
//  Networking
//
//  Created by dante canizo on 10/12/2024.
//

import Foundation

public enum Endpoint {
    case search
    case artist(String)
    case paginatedEndpoint(String)

    var urlString: String {
        switch self {
        case .search: return "database/search"
        case .artist(let id): return "database/search\(id)"
        case .paginatedEndpoint(let path): return path
        }
    }
}

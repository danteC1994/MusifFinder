//
//  SearchRepository.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 10/12/2024.
//

protocol SearchRepository {
    func searchArtists(query: String, pageSize: Int) async throws -> [Artist]
    func loadNextPage(query: String, pageSize: Int) async throws -> [Artist]
}

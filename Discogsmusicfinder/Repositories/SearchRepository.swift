//
//  SearchRepository.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 10/12/2024.
//

protocol SearchRepository {
    func searchArtists(query: String) async throws -> [Artist]
    func loadNextPage() async throws -> [Artist]
    func updateNextPage(with stringURL: String?)
}

//
//  ImageRepository.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 11/12/2024.
//

import SwiftUI

protocol ImageRepository {
    var imageCache: [String: Image] { get }

    func fetchImage(for url: String) async -> Image?
}

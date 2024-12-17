//
//  ImageRepository.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 11/12/2024.
//

import SwiftUI

protocol ImageRepository {
    func fetchImage(for url: String) async -> Image?
}

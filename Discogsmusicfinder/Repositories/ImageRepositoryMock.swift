//
//  ImageRepositoryMock.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 15/12/2024.
//

import SwiftUI

final class ImageRepositoryMock: ImageRepository {
    var imageCache: [String : Image] = [:]
    
    func fetchImage(for url: String) async -> Image? {
        nil
    }
}

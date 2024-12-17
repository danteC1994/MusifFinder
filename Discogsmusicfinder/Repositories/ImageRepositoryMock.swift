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
        switch url {
        case "https://example.com/thumb1.png":
            return Image(systemName: "person.fill")
        case "https://example.com/thumb2.png":
            return Image(systemName: "music.note")
        default:
            return nil
        }
    }
}

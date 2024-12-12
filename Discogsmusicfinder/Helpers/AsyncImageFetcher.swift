//
//  AsyncImageFetcher.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 11/12/2024.
//

import SwiftUI

protocol AsyncImageFetcher {
    func fetchImage(for url: String) async -> Image?
}

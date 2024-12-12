//
//  AsyncImageView.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 11/12/2024.
//

import SwiftUI
import Networking

struct AsyncImageView: View {
    let url: URL?
    @State private var image: Image? = nil
    @State private var isLoading = true
    private let fetcher: AsyncImageFetcher
    private let placeholder: Image

    init(url: URL?, fetcher: AsyncImageFetcher, placeholder: Image = Image(systemName: "photo")) {
        self.url = url
        self.fetcher = fetcher
        self.placeholder = placeholder
    }

    var body: some View {
        Group {
            if let image = image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
            } else if isLoading {
                ProgressView()
                    .frame(width: 50, height: 50)
                    .onAppear {
                        loadImage()
                    }
            } else {
                placeholder
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .cornerRadius(5)
            }
        }
    }

    private func loadImage() {
        guard let url = url?.absoluteString else {
            image = placeholder
            isLoading = false
            return
        }

        Task {
            if let fetchedImage = await fetcher.fetchImage(for: url) {
                withAnimation {
                    image = fetchedImage
                }
            } else {
                print("Image fetch timed out or returned nil.")
            }
            isLoading = false
        }
    }
}

#Preview {
    AsyncImageView(url: URL(filePath: ""), fetcher: MockImageFetcher())
}

fileprivate struct MockImageFetcher: AsyncImageFetcher {
    func fetchImage(for url: String) async -> Image? {
        nil
    }
}

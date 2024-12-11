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
    private let viewModel: HomeViewModel
    private let placeholder: Image

    init(url: URL?, viewModel: HomeViewModel, placeholder: Image = Image(systemName: "photo")) {
        self.url = url
        self.viewModel = viewModel
        self.placeholder = placeholder
    }

    var body: some View {
        Group {
            if let image = image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .cornerRadius(5)
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
        guard let url = url else {
            image = nil
            isLoading = false
            return
        }
        
        Task {
            if let fetchedImage = await viewModel.fetchImage(for: url.absoluteString) {
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
    AsyncImageView(url: URL(filePath: ""), viewModel: .init(repository: SearchRepositoryImplementation(apiClient: APIClientImplementation(baseURL: URL(filePath: "")))))
}

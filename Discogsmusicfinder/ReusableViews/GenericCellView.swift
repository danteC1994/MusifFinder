//
//  ArtistCellView.swift
//  Discogsmusicfinder
//
//  Created by dante canizo on 13/12/2024.
//

import SwiftUI

struct GenericCellView: View {
    struct ArtistCellViewData {
        let imageManager: ImageRepository
        let imageURLString: String?
        let title: String
        let subtitle: String
    }

    let viewData: ArtistCellViewData

    var body: some View {
        HStack {
            rowImage
                .clipShape(Circle())
                .frame(width: 50, height: 50)
            artistRowDescription
                .padding(.leading, 6)
            Spacer()
        }
        .padding(.all, 6)
        .background(RoundedRectangle(cornerRadius: 10)
            .fill(Color(UIColor.systemBackground))
            .shadow(radius: 2))
    }

    @ViewBuilder
    private var rowImage: some View {
        if let imageURLString = viewData.imageURLString {
            ZStack {
                AsyncImageView(url: URL(string: imageURLString), fetcher: viewData.imageManager)
            }
        } else {
            EmptyView()
        }
    }

    private var artistRowDescription: some View {
        VStack(alignment: .leading) {
            Text(viewData.title)
                .font(.headline)
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
            Text(viewData.subtitle)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
        }
    }
}

#Preview {
    GenericCellView(viewData: .init(imageManager: ImageRepositoryMock(), imageURLString: "", title: "Any title", subtitle: "Any subtitle"))
}

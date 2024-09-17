//
//  NetworkImageView.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 09.09.24.
//

import SwiftUI

struct NetworkImageView: View {
    var size: CGFloat = 60
    var cornerRadius: CGFloat = 30
    var imageURL: String
    var defaultImage: String = "person"
    @State private var uiImage = UIImage()
    
    var body: some View {
        VStack {
            if uiImage == UIImage(systemName: defaultImage) {
                Image(systemName: defaultImage)
                    .font(.system(size: size/2))
                    .frame(width: size, height: size)
                    .foregroundColor(Color(.systemPurple))
            } else {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                    .font(.system(size: size/2))
                    .frame(width: size, height: size)
                    .foregroundColor(Color(.systemPurple))
                    .task {
                        do {
                            uiImage =  try await ImageCache.getImage(from: imageURL) ?? UIImage(systemName: defaultImage)!
                        } catch {
                            uiImage = UIImage(systemName: defaultImage)!
                        }
                    }
            }
        }
        .overlay(RoundedRectangle(cornerRadius: cornerRadius) .stroke(Color(.systemPurple), lineWidth: 0))
    }
}

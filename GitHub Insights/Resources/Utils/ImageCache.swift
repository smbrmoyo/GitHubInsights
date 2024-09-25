//
//  ImageCache.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 09.09.24.
//

import UIKit

final class ImageCache {
    static func getImage(from urlString: String) async throws -> UIImage? {
        let cachedImagePath = getCachedImagePath(for: urlString)
        
        if let cachedImage = UIImage(contentsOfFile: cachedImagePath.path) {
            return cachedImage
        }
        
        guard let url = URL(string: urlString) else {
            throw NetworkError.badRequest
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        guard let image = UIImage(data: data) else {
            throw NetworkError.notFound
        }
        
        do {
            try data.write(to: cachedImagePath)
        } catch {
            print("Failed to cache image: \(error)")
        }
        
        return image
    }
    
    /// Helper function to get the local file path where the image will be cached
    static func getCachedImagePath(for urlString: String) -> URL {
        let fileName = urlString.components(separatedBy: "/").last ?? "profile_image"
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        return documentsDirectory.appendingPathComponent(fileName)
    }
}

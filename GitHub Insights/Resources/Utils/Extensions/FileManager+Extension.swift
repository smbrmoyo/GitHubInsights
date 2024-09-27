//
//  FileManager+Extension.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 27.09.24.
//

import Foundation

extension FileManager {
    /**
     Generic static function to load and decode JSON data from a file.
     - Parameters:
        - fileName: The name of the JSON file (without extension).
     - Returns: A decoded object of the provided type.
     - Throws: An error if the file cannot be loaded or the data cannot be decoded.
     */
    static func loadJson<T: Decodable>(fileName: String) throws -> T {
        
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            throw NSError(domain: "FileManagerError", code: 404, userInfo: [NSLocalizedDescriptionKey: "File \(fileName).json not found."])
        }
        
        let data = try Data(contentsOf: url)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(T.self, from: data)
    }
}

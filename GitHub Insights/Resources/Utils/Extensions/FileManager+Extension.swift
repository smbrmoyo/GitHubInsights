//
//  FileManager+Extension.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 27.09.24.
//

import Foundation

extension FileManager {
    /**
     Generic function to load and decode JSON data from a file.
     - Parameters:
        - fileName: The name of the JSON file (without extension).
        - type: The type to decode the JSON into. This type must conform to Decodable.
     - Returns: A decoded object of the provided type.
     - Throws: An error if the file cannot be loaded or the data cannot be decoded.
     */
    func loadJson<T: Decodable>(fileName: String, as type: T.Type) throws -> T {
        // Get the URL for the JSON file in the main bundle
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            throw NSError(domain: "FileManagerHelperError", code: 404, userInfo: [NSLocalizedDescriptionKey: "File \(fileName).json not found."])
        }
        
        // Load the data from the file
        let data = try Data(contentsOf: url)
        
        // Decode the JSON data into the provided type
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}

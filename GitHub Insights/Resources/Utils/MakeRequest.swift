//
//  MakeRequest.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 08.09.24.
//

import Foundation

func makeRequest<T: Codable>(
    from urlString: String,
    method: String = "GET",
    parameters: [String: String] = [:],
    body: [String: Any]? = nil,
    headers: [String: String]? = nil
) async throws -> T {
    
    let components = URLComponents(string: urlString)
    guard var components = components else {
        throw NetworkError.badRequest
    }
    
    if !parameters.keys.isEmpty {
        let queryItems = parameters.keys.map { URLQueryItem(name: $0, value: parameters[$0]) }
        components.queryItems = queryItems
    }
    
    guard let url = components.url else {
        throw NetworkError.badRequest
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = method
    request.allHTTPHeaderFields = headers
    
    if method == "POST", let body = body {
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        } catch {
            throw NetworkError.badRequest
        }
    }
    
    let (data, response) = try await URLSession.shared.data(for: request)
    
    guard let  statusCode = (response as? HTTPURLResponse)?.statusCode else {
        throw NetworkError.unknownError
    }
    
    guard statusCode == 200 else {
        throw handleAPIError(forStatusCode: statusCode)
    }
    
    do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(T.self, from: data)
    } catch {
        print(error)
        throw error
    }
}

private func handleAPIError(forStatusCode statusCode: Int) -> NetworkError {
    switch statusCode {
    case 400:
        return NetworkError.badRequest
    case 401:
        return NetworkError.unauthorized
    case 403:
        return NetworkError.forbidden
    case 404:
        return NetworkError.notFound
    case 500:
        return NetworkError.serverError
    case 502:
        return NetworkError.badGateway
    case 503:
        return NetworkError.serviceUnavailable
    default:
        return NetworkError.unknownError
    }
}

//
//  Enums.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 08.09.24.
//

import Foundation

enum NetworkError: Error {
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case badGateway
    case serverError
    case serviceUnavailable
    case unknownError
    case custom(message: String)
    
    var localizedDescription: String {
            switch self {
            case .badRequest:
                return "Bad Request (400): The server could not understand the request."
            case .unauthorized:
                return "Unauthorized (401): Access is denied due to invalid credentials."
            case .forbidden:
                return "Forbidden (403): You do not have permission to access this resource."
            case .notFound:
                return "Not Found (404): The requested resource could not be found."
            case .serverError:
                return "Internal Server Error (500): The server encountered an internal error."
            case .badGateway:
                return "Bad Gateway (502): The server received an invalid response from an upstream server."
            case .serviceUnavailable:
                return "Service Unavailable (503): The server is temporarily unavailable."
            case .unknownError:
                return "Unknown Error: An unknown error occurred."
            case .custom(message: let message):
                return message
            }
        }
}

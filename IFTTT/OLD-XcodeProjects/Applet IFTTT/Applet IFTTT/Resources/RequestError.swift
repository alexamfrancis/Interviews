//
//  RequestError.swift
//  Applet IFTTT
//
//  Created by Alexa Francis on 9/17/19.
//  Copyright © 2019 Alexa Francis. All rights reserved.
//

import Foundation
import Alamofire

/// Wrapper for all request errors. Allows us to pass the reponse down to the error handler if they want it.
public struct RequestError: LocalizedError {
    public let underlyingError: Error
    public let response: DefaultDataResponse?
    
    public var localizedDescription: String {
        return underlyingError.localizedDescription
    }
    
    public var errorDescription: String? {
        return (underlyingError as? LocalizedError)?.errorDescription
    }
    
    public var recoverySuggestion: String? {
        return (underlyingError as? LocalizedError)?.recoverySuggestion
    }
    
    public var failureReason: String? {
        return (underlyingError as? LocalizedError)?.failureReason
    }
    
    public var statusCode: Int? {
        return response?.response?.statusCode
    }
}

/// Contains errors which can occur when doing requests or using BaseRequestManager functions
///
/// - noURLForEndpointAvailable: No URL can be found in the Configuration.plist for the given endpoint.
/// - invalidResponse: Something about the response was not as expected.
/// - invalidRequest: Something about the request was not as expected.
/// - serverError: Some kind of server error happened
public enum SpecificRequestError: LocalizedError {
    case noURLForEndpointAvailable
    case invalidResponse(String)
    case invalidRequest(String)
    case serverErrors([ServerError])
    
    public var errorDescription: String? {
        switch self {
        case .serverErrors(let errors):
            let descriptions = errors.map({ $0.localizedDescription })
            return descriptions.joined(separator: "\n ")
        default:
            return nil
        }
    }
    
    public var recoverySuggestion: String? {
        switch self {
        case .serverErrors(let errors) where errors.count == 1:
            return errors.first?.recoverySuggestion
        default:
            return nil
        }
    }
    
    public var failureReason: String? {
        switch self {
        case .serverErrors(let errors) where errors.count == 1:
            return errors.first?.failureReason
        default:
            return nil
        }
    }
}

/// Errors explicitly given by the server.
public enum ServerError: LocalizedError {
    case genericError(code: String, message: String?)
    
    init(code: String, message: String?) {
        // Check for specific codes and generate more explicit errors here if we want.
        self = .genericError(code: code, message: message)
    }
    
    public var errorDescription: String? {
        switch self {
        case .genericError(let message):
            return message.message
        }
    }
    
    public var failureReason: String? {
        switch self {
        case .genericError(let code, _):
            return code
        }
    }
    
    public var recoverySuggestion: String? {
        switch self {
        case .genericError(let optionalMessage):
            var suggestions: [String] = []
            suggestions.append(optionalMessage.message ?? "")
            
            // Add message from the server for Debug builds
            #if DEBUG
            if let message = optionalMessage.message {
                suggestions.append("[DEBUG] \(message)")
            }
            #endif
            
            return suggestions.isEmpty ? nil : suggestions.joined(separator: "\r\r")
        }
    }
}

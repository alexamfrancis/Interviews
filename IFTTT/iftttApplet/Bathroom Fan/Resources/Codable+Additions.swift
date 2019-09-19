//
//  Codable+Additions.swift
//  Bathroom Fan
//
//  Created by Alexa Francis on 9/19/19.
//  Copyright © 2019 Alexa Francis. All rights reserved.
//

import Foundation

public enum CodableError: LocalizedError {
    case noDefaultValueWhileDecoding(key: String)
    
    public var localizedDescription: String {
        switch self {
        case .noDefaultValueWhileDecoding(let key):
            return "No default value provided for a required key = \(key)."
        }
    }
}

extension KeyedDecodingContainer {
    public func decodeIfPresent<T>(_ type: T.Type = T.self, forKey key: KeyedDecodingContainer.Key, withDefaultValue defaultValue: T? = nil) throws -> T? where T: Decodable {
        return try decodeIfPresent(type, forKey: key) ?? defaultValue
    }
    
    public func decode<T>(_ type: T.Type = T.self, forKey key: KeyedDecodingContainer.Key, withDefaultValue defaultValue: T? = nil) throws -> T where T: Decodable {
        if let valueIfPresent = try decodeIfPresent(type, forKey: key) {
            return valueIfPresent
        } else if let defaultValue = defaultValue {
            return defaultValue
        }
        
        throw CodableError.noDefaultValueWhileDecoding(key: key.stringValue)
    }
}

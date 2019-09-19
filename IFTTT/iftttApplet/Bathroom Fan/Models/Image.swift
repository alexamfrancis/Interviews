//
//  Image.swift
//  Bathroom Fan
//
//  Created by Alexa Francis on 9/18/19.
//  Copyright © 2019 Alexa Francis. All rights reserved.
//

import Foundation

enum BackgroundImageSize: String, Codable {
    case small
    case medium
    case large
    
    var codingKey: String {
        switch self {
        case .small:
            return "background_image_url_1x"
        case .medium:
            return "background_image_url_2x"
        case .large:
            return "background_image_url_3x"
        }
    }
}

enum Icon: String, Codable {
    case monochrome
    case largeMonochrome
    case imageURL
    case largeImageURL
    
    var codingKey: String {
        switch self {
        case .monochrome:
            return "monochrome_image_url"
        case .largeMonochrome:
            return "lrg_monochrome_image_url"
        case .imageURL:
            return "image_url"
        case .largeImageURL:
            return "lrg_image_url"
        }
    }
}

class Image: Codable {
    var imageSize: BackgroundImageSize
    var icon: Icon
}

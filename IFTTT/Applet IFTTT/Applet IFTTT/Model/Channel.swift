//
//  Channel.swift
//  Applet IFTTT
//
//  Created by Alexa Francis on 9/16/19.
//  Copyright © 2019 Alexa Francis. All rights reserved.
//

import Foundation

fileprivate enum CodingKeys: String, Codable {
    case moduleName
    case name
    case shortName
    case description
    case brandColor
    case monochromeImageURL
    case largeMonochromeImageURL
    case imageURL
    case isHidden
    case isConected
    case requiresAuthentication
    
    var keys: String {
                switch self {
                case .moduleName:
                    return "module_name"
                case .name:
                    return "short_name"
                case .shortName:
                    return "name"
                case .description:
                    return "description_html"
                case .brandColor:
                    return "brand_color"
                case .monochromeImageURL:
                    return "monochrome_image_url"
                case .largeMonochromeImageURL:
                    return "lrg_monochrome_image_url"
                case .imageURL:
                    return "image_url"
                case .isHidden:
                    return "is_hidden"
                case .isConected:
                    return "connected"
                case .requiresAuthentication:
                    return "requires_user_authentication"
                }
            }
}

/// There are four icons for each channel. These can be downloaded from the values for the following keys for each channel:
///
/// - monochrome_image_url
/// - lrg_monochrome_image_url
/// - image_url
/// - lrg_image_url
class Channel: Codable {
    var moduleName: String?
    var name: String?
    var shortName: String?
    var description: String?
    var brandColor: String?
    var monochromeImageURL: String?
    var largeMonochromeImageURL: String?
    var imageURL: String?
    var isHidden: String?
    var isConected: String?
    var requiresAuthentication: String?
    
    init(moduleName: String, name: String, shortName: String, description: String, brandColor: String, monochromeImageURL: String, largeMonochromeImageURL: String, imageURL: String, isHidden: String, isConected: String, requiresAuthentication: String) {
        self.moduleName = moduleName
        self.name = name
        self.shortName = shortName
        self.description = description
        self.brandColor = brandColor
        self.monochromeImageURL = monochromeImageURL
        self.largeMonochromeImageURL = largeMonochromeImageURL
        self.imageURL = imageURL
        self.isHidden = isHidden
        self.isConected = isConected
        self.requiresAuthentication = requiresAuthentication
    }
}


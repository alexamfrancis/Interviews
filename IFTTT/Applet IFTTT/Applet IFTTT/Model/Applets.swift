//
//  Applets.swift
//  Applet IFTTT
//
//  Created by Alexa Francis on 9/16/19.
//  Copyright © 2019 Alexa Francis. All rights reserved.
//

import Foundation


/// In the applet response, status can be one of the following:
/// - enabled_for_user - Currently turned on
/// - disabled_for_user - Turned off after being turned on
/// - never_enabled_for_user - Deleted by user or never turned on
/// NOTE: Applets that are disabled_for_user or never_enabled_for_user can be displayed with the same grayed out style indicated in the applet list view screenshot.

struct Applet {
    var id: String?
    var created: String?
    var serviceSlug: String?
    var serviceOwner: String?
    var name: String?
    var description: String?
    var brandColor: String?
    var status: String?
    var author: String?
    var installCount: String?
    var backgroundImages: String?
    var userFeedback: String?
}

extension Applet: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case id
        case created
        case serviceSlug
        case serviceOwner
        case name
        case description
        case brandColor
        case status
        case author
        case installCount
        case backgroundImages
        case userFeedback
        
        var codingKey: String {
            switch self {
            case .id:
                return "id"
            case .created:
                return "created_at"
            case .serviceSlug:
                return "service_slug"
            case .serviceOwner:
                return "by_service_owner"
            case .name:
                return "name"
            case .description:
                return "description"
            case .brandColor:
                return "brand_color"
            case .status:
                return "status"
            case .author:
                return "author"
            case .installCount:
                return "installs_count"
            case .backgroundImages:
                return "background_images"
            case .userFeedback:
                return "applet_feedback_by_user"
            }
        }
        
    }
    
    //    var requestParameters: [String: Any] {
    //        let parameters: [String: Any] = [
    //            CodingKeys.categories.rawValue: self.categories.map { $0.requestParameters },
    //            CodingKeys.storeNumber.rawValue: self.storeNumber,
    //            CodingKeys.version.rawValue: self.version
    //        ]
    //        return parameters
    //    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.created = try container.decode(String.self, forKey: .created)
        self.serviceSlug = try container.decode(String.self, forKey: .serviceSlug)
        self.serviceOwner = try container.decode(String.self, forKey: .serviceOwner)
        self.name = try container.decode(String.self, forKey: .name)
        self.id = try container.decode(String.self, forKey: .id)
        self.description = try container.decode(String.self, forKey: .description)
        self.brandColor = try container.decode(String.self, forKey: .brandColor)
        self.status = try container.decode(String.self, forKey: .status)
        self.author = try container.decode(String.self, forKey: .author)
        self.installCount = try container.decode(String.self, forKey: .installCount)
        self.backgroundImages = try container.decode(String.self, forKey: .backgroundImages)
        self.userFeedback = try container.decode(String.self, forKey: .userFeedback)
    }
    
}
//
//class Applet: Codable {
//    enum CodingKeys: String, Codable {
//        case id
//        case created
//        case serviceSlug
//        case serviceOwner
//        case name
//        case description
//        case brandColor
//        case status
//        case author
//        case installCount
//        case backgroundImages
//        case userFeedback
//
//
//        var codingKey: String {
//            switch self {
//            case .id:
//                return "id"
//            case .created:
//                return "created_at"
//            case .serviceSlug:
//                return "service_slug"
//            case .serviceOwner:
//                return "by_service_owner"
//            case .name:
//                return "name"
//            case .description:
//                return "description"
//            case .brandColor:
//                return "brand_color"
//            case .status:
//                return "status"
//            case .author:
//                return "author"
//            case .installCount:
//                return "installs_count"
//            case .backgroundImages:
//                return "background_images"
//            case .userFeedback:
//                return "applet_feedback_by_user"
//            }
//        }
//    }
//
//    var id: String?
//    var created: String?
//    var serviceSlug: String?
//    var serviceOwner: String?
//    var name: String?
//    var description: String?
//    var brandColor: String?
//    var status: String?
//    var author: String?
//    var installCount: String?
//    var backgroundImages: String?
//    var userFeedback: String?
//
//    required public init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        self.id = try container.decode(forKey: .id)
//        self.created = try container.decode(forKey: .created)
//        self.serviceSlug = try container.decode(forKey: .serviceSlug)
//        self.serviceOwner = try container.decode(forKey: .serviceOwner)
//        self.name = try container.decode(forKey: .name)
//        self.id = try container.decode(forKey: .id)
//        self.description = try container.decode(forKey: .description)
//        self.brandColor = try container.decode(forKey: .brandColor)
//        self.status = try container.decode(forKey: .status)
//        self.author = try container.decode(forKey: .author)
//        self.installCount = try container.decode(forKey: .installCount)
//        self.backgroundImages = try container.decode(forKey: .backgroundImages)
//        self.userFeedback = try container.decode(forKey: .userFeedback)
//    }
//}
//


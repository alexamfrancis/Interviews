//
//  Applet.swift
//  Bathroom Fan
//
//  Created by Alexa Francis on 9/18/19.
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
    var serviceOwner: Bool?
    var name: String?
    var description: String?
    var brandColor: String?
    var status: String?
    var author: String?
    var installCount: Int?
    var backgroundImages: String?
    var userFeedback: String?
    var channels: [Channel]
    var valuePropositions: String?
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
        case valuePropositions
        case channels
        
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
            case .channels:
                return "channels"
            case .valuePropositions:
                return "value_propositions"
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
        self.serviceOwner = try container.decode(Bool.self, forKey: .serviceOwner)
        self.name = try container.decode(String.self, forKey: .name)
        self.id = try container.decode(String.self, forKey: .id)
        self.description = try container.decode(String.self, forKey: .description)
        self.brandColor = try container.decode(String.self, forKey: .brandColor)
        self.status = try container.decode(String.self, forKey: .status)
        self.author = try container.decode(String.self, forKey: .author)
        self.installCount = try container.decode(Int.self, forKey: .installCount)
        self.backgroundImages = try container.decode(String.self, forKey: .backgroundImages)
        self.userFeedback = try container.decode(String.self, forKey: .userFeedback)
        self.channels = try container.decode([Channel].self, forKey: .channels)
        self.valuePropositions = try container.decode(String.self, forKey: .valuePropositions)
    }
    
}

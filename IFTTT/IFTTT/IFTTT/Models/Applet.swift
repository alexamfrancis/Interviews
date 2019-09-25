//
//  Applet.swift
//  IFTTT
//
//  Created by Alexa Francis on 9/20/19.
//  Copyright © 2019 Alexa Francis. All rights reserved.
//

import Foundation

/// In the applet response, status can be one of the following:
/// - enabled_for_user - Currently turned on
/// - disabled_for_user - Turned off after being turned on
/// - never_enabled_for_user - Deleted by user or never turned on
/// NOTE: Applets that are disabled_for_user or never_enabled_for_user can be displayed with the same grayed out style indicated in the applet list view screenshot.

struct Applet {
    var created: Date? = Date() // TODO: remove default value `Date()`
    var id: String?
    var serviceSlug: String?
    var serviceOwner: Bool?
    var name: String?
    var description: String?
    var brandColor: String?
    var status: Status?
    var author: String?
    var installCount: Int?
    var backgroundImages: BackgroundImages?
    var userFeedback: String?
    var channels: [Channel]?
    var valuePropositions: String?
}

extension Applet: Codable {
    private enum CodingKeys: String, CodingKey {
        case created = "created_at"
        case id
        case serviceSlug = "service_slug"
        case serviceOwner = "by_service_owner"
        case name
        case description
        case brandColor = "brand_color"
        case status
        case author
        case installCount = "installs_count"
        case backgroundImages = "background_images"
        case userFeedback = "applet_feedback_by_user"
        case valuePropositions = "value_propositions"
        case channels
    }
    
    enum Status: String, Codable {
        case enabled = "enabled_for_user"
        case disabled = "disabled_for_user"
        case neverEnabled = "never_enabled_for_user"
    }
    
    struct BackgroundImages: Codable {
        var small: String?
        var medium: String?
        var large: String?
        
        private enum CodingKeys: String, CodingKey {
            case small = "background_image_url_1x"
            case medium = "background_image_url_2x"
            case large = "background_image_url_3x"
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.small = try container.decode(String?.self, forKey: .small)
            self.medium = try container.decode(String?.self, forKey: .medium)
            self.large = try container.decode(String?.self, forKey: .large)
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let date = try container.decode(String?.self, forKey: .created) {
            self.created = Date.FromString(date)
        }
        self.id = try container.decode(String?.self, forKey: .id)
        self.serviceSlug = try? container.decode(String?.self, forKey: .serviceSlug)
        self.serviceOwner = try? container.decode(Bool?.self, forKey: .serviceOwner)
        self.name = try? container.decode(String?.self, forKey: .name)
        self.description = try? container.decode(String?.self, forKey: .description)
        self.brandColor = try? container.decode(String?.self, forKey: .brandColor)
        self.status = try? container.decode(Status?.self, forKey: .status)
        self.author = try? container.decode(String?.self, forKey: .author)
        self.installCount = try? container.decode(Int?.self, forKey: .installCount)
        self.backgroundImages = try? container.decode(BackgroundImages?.self, forKey: .backgroundImages)
        self.userFeedback = try? container.decode(String?.self, forKey: .userFeedback)
        self.channels = try? container.decode([Channel]?.self, forKey: .channels)
        self.valuePropositions = try? container.decode(String?.self, forKey: .valuePropositions)
    }
}

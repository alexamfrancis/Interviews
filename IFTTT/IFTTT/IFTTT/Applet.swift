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
    var backgroundImages: BackgroundImages?
    var userFeedback: String?
    var channels: [Channel]?
    var valuePropositions: String?
}

extension Applet: Codable {
    private enum CodingKeys: String, CodingKey {
        case id
        case created = "created_at"
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
        self.id = try container.decode(String?.self, forKey: .id)
        self.created = try? container.decode(String?.self, forKey: .created)
        self.serviceSlug = try? container.decode(String?.self, forKey: .serviceSlug)
        self.serviceOwner = try? container.decode(Bool?.self, forKey: .serviceOwner)
        self.name = try? container.decode(String?.self, forKey: .name)
        self.description = try? container.decode(String?.self, forKey: .description)
        self.brandColor = try? container.decode(String?.self, forKey: .brandColor)
        self.status = try? container.decode(String?.self, forKey: .status)
        self.author = try? container.decode(String?.self, forKey: .author)
        self.installCount = try? container.decode(Int?.self, forKey: .installCount)
        self.backgroundImages = try? container.decode(BackgroundImages?.self, forKey: .backgroundImages)
        self.userFeedback = try? container.decode(String?.self, forKey: .userFeedback)
        self.channels = try? container.decode([Channel]?.self, forKey: .channels)
        self.valuePropositions = try? container.decode(String?.self, forKey: .valuePropositions)
    }
    
}

/// In the applet response, status can be one of the following:
/// - enabled_for_user - Currently turned on
/// - disabled_for_user - Turned off after being turned on
/// - never_enabled_for_user - Deleted by user or never turned on
/// NOTE: Applets that are disabled_for_user or never_enabled_for_user can be displayed with the same grayed out style indicated in the applet list view screenshot.
//
//class Applet: Codable {
//    var id: String?
//    var created_at: String?
//    var service_slug: String?
//    var by_service_owner: String?
//    var name: String?
//    var description: String?
//    var brand_color: String?
//    var status: String?
//    var author: String?
//    var installs_count: String?
//    var background_images: String?
//    var applet_feedback_by_user: String?
//    var channels: String?
//}

//struct Applet: Codable {
//
//    enum Keys: RawRepresentable, Codable {
//        case temp-created_at
//        case temp-id
//        case temp-service_slug
//        case temp-by_service_owner
//        case temp-name
//        case temp-description
//        case temp-brand_color
//        case temp-status
//        case temp-author
//        case temp-installs_count
//        case temp-applet_feedback_by_user
//        case temp-backgroundImages
//        case temp-propositions
//        case channels
//
//    }
//    struct CodingKeys: String, Codable {
//        var created_at: String = "temp-created_at"
//        var id: String = "temp-id"
//        var service_slug: String = "temp-service_slug"
//        var by_service_owner: String = "temp-by_service_owner"
//        var name: String = "temp-name"
//        var description: String = "temp-description"
//        var brand_color: String = "temp-brand_color"
//        var status: String = "temp-status"
//        var author: String = "temp-author"
//        var installs_count: String = "temp-installs_count"
//        var applet_feedback_by_user: String = "temp-applet_feedback_by_user"
//        var background_images: String = "temp-backgroundImages"
//        var value_propositions: String = "temp-propositions"
//        var channels: [Channel] = []
//    }
//
//    var created_at: String = "temp-created_at"
//    var id: String = "temp-id"
//    var service_slug: String = "temp-service_slug"
//    var by_service_owner: String = "temp-by_service_owner"
//    var name: String = "temp-name"
//    var description: String = "temp-description"
//    var brand_color: String = "temp-brand_color"
//    var status: String = "temp-status"
//    var author: String = "temp-author"
//    var installs_count: String = "temp-installs_count"
//    var applet_feedback_by_user: String = "temp-applet_feedback_by_user"
//    var background_images: String = "temp-backgroundImages"
//    var value_propositions: String = "temp-propositions"
//    var channels: [Channel] = []
//
//    init?(dictionary: [String: Any]) {
//        guard let hostName = dictionary[CodingKeys] as? String,
//            let isSecure = dictionary["secure"] as? Bool else {
//                return nil
//        }
//
//        let isProduction = dictionary["isProduction"] as? Bool ?? false
//        let isCustom = dictionary["isCustom"] as? Bool ?? false
//
//        self.key = key
//        self.host = hostName
//        self.isSecure = isSecure
//        self.isProduction = isProduction
//        self.isCustom = isCustom
//
//        if let pinnedCertificates = dictionary["certificatePinning"] as? [[String: String]] {
//            self.certificatePinning = []
//            Log.debug("\(pinnedCertificates)")
//            for certificateDetails in pinnedCertificates {
//                self.certificatePinning.append(SSLCertificate(certName: certificateDetails["cert"]!, hostName: certificateDetails["hostName"]!))
//            }
//        } else {
//            self.certificatePinning = []
//        }
//    }
//}

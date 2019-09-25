//
//  Channel.swift
//  IFTTT
//
//  Created by Alexa Francis on 9/23/19.
//  Copyright © 2019 Alexa Francis. All rights reserved.
//

import Foundation

struct Channel: Codable {
    enum ModuleName: String, Codable {
        case if_notifications
        case do_note
        case weather
        case space
        case android_device
        case wikipedia
        case do_button
        case location
    }
    
    var module_name: String
    var name: String
    var short_name: String
    var description_html: String
    var brand_color: String
    var monochrome_image_url: String
    var lrg_monochrome_image_url: String
    var image_url: String
    var lrg_image_url: String
    var is_hidden: Bool
    var connected: Bool
    var requires_user_authentication: Bool
}


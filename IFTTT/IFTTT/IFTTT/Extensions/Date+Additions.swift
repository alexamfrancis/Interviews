//
//  Date+Additions.swift
//  IFTTT
//
//  Created by Alexa Francis on 9/24/19.
//  Copyright © 2019 Alexa Francis. All rights reserved.
//

import Foundation

extension Date {
    public static func FromString(_ dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        // `yyyy-MM-dd-HH:mm:ss Z` —— for example: `2019-08-08 07:10:25 -0700`
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        guard let date = dateFormatter.date(from: dateString) else {
            print("Date deconstruction failure")
            return Date()
        }
        return date
    }
}

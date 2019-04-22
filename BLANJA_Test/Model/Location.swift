//
//  Location.swift
//  Gojek_Test
//
//  Created by Ernando Kasaluhe on 09/03/19.
//  Copyright © 2019 Ernando. All rights reserved.
//

import Foundation

final class Location: NSObject {
    var name: String
    var region: String
    var country: String
    var lat: String
    var lon: String
    var tzId: String
    var epoch: Int
    var localTime: String
    
    init?(dictionary: [String: Any]) {
        
        if let name = dictionary["name"] as? String {
            self.name = name
        } else {
            self.name = ""
        }
        
        if let region = dictionary["region"] as? String {
            self.region = region
        } else {
            self.region = ""
        }
        
        if let country = dictionary["country"] as? String {
            self.country = country
        } else {
            self.country = ""
        }
        
        if let lat = dictionary["lat"] as? String {
            self.lat = lat
        } else {
            self.lat = ""
        }
        
        if let lon = dictionary["lon"] as? String {
            self.lon = lon
        } else {
            self.lon = ""
        }
        
        if let tzId = dictionary["tz_id"] as? String {
            self.tzId = tzId
        } else {
            self.tzId = ""
        }
        
        if let epoch = dictionary["localtime_epoch"] as? Int {
            self.epoch = epoch
        } else {
            self.epoch = 0
        }
        
        if let localTime = dictionary["localtime"] as? String {
            self.localTime = localTime
        } else {
            self.localTime = ""
        }
    }
}

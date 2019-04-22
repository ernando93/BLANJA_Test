//
//  CurrentWeather.swift
//  Gojek_Test
//
//  Created by Ernando Kasaluhe on 09/03/19.
//  Copyright © 2019 Ernando. All rights reserved.
//

import Foundation

struct Condition {
    let text: String
    let icon: String
    let code: Int
}

final class CurrentWeather: NSObject {
    var epoch: Int
    var lastUpdate: String
    var tempC: Double
    var tempF: Double
    var isDay: Double
    var condition: Condition?
    var windMph: Double
    var windKph: Double
    var windDegree: Double
    var windDir: String
    var pressureMb: Double
    var pressureIn: Double
    var precipMm: Double
    var precipIn: Double
    var humidity: Int
    var cloud: Int
    var feelsLikeC: Double
    var feelsLikeF: Double
    var visKm: Double
    var visMiles: Double
    var uv: Double
    
    init?(dictionary: [String: Any]) {
        
        if let epoch = dictionary["last_updated_epoch"] as? Int {
            self.epoch = epoch
        } else {
            self.epoch = 0
        }
        
        if let lastUpdate = dictionary["last_updated"] as? String {
            self.lastUpdate = lastUpdate
        } else {
            self.lastUpdate = ""
        }
        
        if let tempC = dictionary["temp_c"] as? Double {
            self.tempC = tempC
        } else {
            self.tempC = 0
        }
        
        if let tempF = dictionary["temp_f"] as? Double {
            self.tempF = tempF
        } else {
            self.tempF = 0
        }
        
        if let isDay = dictionary["is_day"] as? Double {
            self.isDay = isDay
        } else {
            self.isDay = 0
        }
        
        if let condition = dictionary["condition"] as? [String: Any] {
            var tempText: String = ""
            var tempIcon: String = ""
            var tempCode: Int = 0
            
            if let text = condition["text"] as? String {
                tempText = text
            }
            
            if let icon = condition["icon"] as? String {
                tempIcon = icon
            }
            
            if let code = condition["code"] as? Int {
                tempCode = code
            }
            
            self.condition = Condition(text: tempText, icon: tempIcon, code: tempCode)
        }
        
        if let windMph = dictionary["wind_mph"] as? Double {
            self.windMph = windMph
        } else {
            self.windMph = 0
        }
        
        if let windKph = dictionary["wind_kph"] as? Double {
            self.windKph = windKph
        } else {
            self.windKph = 0
        }
        
        if let windDegree = dictionary["wind_degree"] as? Double {
            self.windDegree = windDegree
        } else {
            self.windDegree = 0
        }
        
        if let windDir = dictionary["wind_dir"] as? String {
            self.windDir = windDir
        } else {
            self.windDir = ""
        }
        
        if let pressureMb = dictionary["pressure_mb"] as? Double {
            self.pressureMb = pressureMb
        } else {
            self.pressureMb = 0
        }
        
        if let pressureIn = dictionary["pressure_in"] as? Double {
            self.pressureIn = pressureIn
        } else {
            self.pressureIn = 0
        }
        
        if let precipMm = dictionary["precip_mm"] as? Double {
            self.precipMm = precipMm
        } else {
            self.precipMm = 0
        }
        
        if let precipIn = dictionary["precip_in"] as? Double {
            self.precipIn = precipIn
        } else {
            self.precipIn = 0
        }
        
        if let humidity = dictionary["humidity"] as? Int {
            self.humidity = humidity
        } else {
            self.humidity = 0
        }
        
        if let cloud = dictionary["cloud"] as? Int {
            self.cloud = cloud
        } else {
            self.cloud = 0
        }
        
        if let feelsLikeC = dictionary["feelslike_c"] as? Double {
            self.feelsLikeC = feelsLikeC
        } else {
            self.feelsLikeC = 0
        }
        
        if let feelsLikeF = dictionary["feelslike_f"] as? Double {
            self.feelsLikeF = feelsLikeF
        } else {
            self.feelsLikeF = 0
        }
        
        if let visKm = dictionary["vis_km"] as? Double {
            self.visKm = visKm
        } else {
            self.visKm = 0
        }
        
        if let visMiles = dictionary["vis_miles"] as? Double {
            self.visMiles = visMiles
        } else {
            self.visMiles = 0
        }
        
        if let uv = dictionary["uv"] as? Double {
            self.uv = uv
        } else {
            self.uv = 0
        }
    }
}

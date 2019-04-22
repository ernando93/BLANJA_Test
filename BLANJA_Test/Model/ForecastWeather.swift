//
//  ForecastWeather.swift
//  Gojek_Test
//
//  Created by Ernando Kasaluhe on 09/03/19.
//  Copyright © 2019 Ernando. All rights reserved.
//

import Foundation

struct Day {
    let maxTempC: Double
    let maxTempF: Double
    let minTempC: Double
    let minTempF: Double
    let avgTempC: Double
    let avgTempF: Double
    let maxWindMph: Double
    let maxWindKph: Double
    let totalPrecipMm: Double
    let totalPrecipIn: Double
    let avgVisKm: Double
    let avgVisMiles: Double
    let avgHumidity: Int
    let condition: Condition?
    let uv: Double
}

struct Astro {
    let sunrise: String
    let sunset: String
    let moonrise: String
    let moonset: String
}

struct Forecastday {
    let date: String
    let dateEpoch: Int
    let day: Day?
    let astro: Astro?
}

final class ForecastWeather: NSObject {
    var forecastday = [Forecastday]()
    
    init?(dictionary: [String: Any]) {
        
        if let forecastday = dictionary["forecastday"] as? [[String: Any]] {
            
            var tempDate: String = ""
            var tempDateEpoch: Int = 0
            var tempDay: Day?
            var tempAstro: Astro?
            
            for data in forecastday {
                
                if let date = data["date"] as? String {
                    tempDate = date
                }
                
                if let dateEpoch = data["date_epoch"] as? Int {
                    tempDateEpoch = dateEpoch
                }
                
                if let day = data["day"] as? [String: Any] {
                    
                    var tempMaxC: Double = 0
                    var tempMaxF: Double = 0
                    var tempMinC: Double = 0
                    var tempMinF: Double = 0
                    var tempAvgC: Double = 0
                    var tempAvgF: Double = 0
                    var tempMaxWindMph: Double = 0
                    var tempMaxWindKph: Double = 0
                    var tempTotalPrecipMM: Double = 0
                    var tempTotalPrecipIn: Double = 0
                    var tempAvgVisKm: Double = 0
                    var tempAvgVisMiles: Double = 0
                    var tempAvgHumadity: Int = 0
                    var tempCondition: Condition?
                    var tempUv: Double = 0
                
                    if let maxTempC = day["maxtemp_c"] as? Double {
                        tempMaxC = maxTempC
                    }
                    
                    if let maxTempF = day["maxtemp_f"] as? Double {
                        tempMaxF = maxTempF
                    }
                    
                    if let minTempC = day["mintemp_c"] as? Double {
                        tempMinC = minTempC
                    }
                    
                    if let minTempF = day["mintemp_f"] as? Double  {
                        tempMinF = minTempF
                    }
                    
                    if let avgTempC = day["avgtemp_c"] as? Double {
                        tempAvgC = avgTempC
                    }
                    
                    if let avgTempF = day["avgtemp_f"] as? Double {
                        tempAvgF = avgTempF
                    }
                    
                    if let maxWindMph = day["maxwind_mph"] as? Double  {
                        tempMaxWindMph = maxWindMph
                    }
                    
                    if let maxWindhKph = day["maxwind_kph"] as? Double  {
                        tempMaxWindKph = maxWindhKph
                    }
                    
                    if let totalPrecipMm = day["totalprecip_mm"] as? Double {
                        tempTotalPrecipMM = totalPrecipMm
                    }
                    
                    if let totalPrecipIn = day["totalprecip_in"] as? Double {
                        tempTotalPrecipIn = totalPrecipIn
                    }
                    
                    if let avgVisKm = day["avgvis_km"] as? Double {
                        tempAvgVisKm = avgVisKm
                    }
                    
                    if let avgVisMiles = day["avgvis_miles"] as? Double {
                        tempAvgVisMiles = avgVisMiles
                    }
                    
                    if let avgHumidity = day["avghumidity"] as? Int {
                        tempAvgHumadity = avgHumidity
                    }
                    
                    if let condition = day["condition"] as? [String: Any] {
                        
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
                        
                        tempCondition = Condition(text: tempText, icon: tempIcon, code: tempCode)
                    }
                    
                    if let uv = day["uv"] as? Double {
                        tempUv = uv
                    }
                    
                    tempDay = Day(maxTempC: tempMaxC, maxTempF: tempMaxF, minTempC: tempMinC, minTempF: tempMinF, avgTempC: tempAvgC, avgTempF: tempAvgF, maxWindMph: tempMaxWindMph, maxWindKph: tempMaxWindKph, totalPrecipMm: tempTotalPrecipMM, totalPrecipIn: tempTotalPrecipIn, avgVisKm: tempAvgVisKm, avgVisMiles: tempAvgVisMiles, avgHumidity: tempAvgHumadity, condition: tempCondition, uv: tempUv)
                }
                
                if let astro = data["astro"] as? [String: Any] {
                
                    var tempSunrise: String = ""
                    var tempSunset: String = ""
                    var tempMoonrise: String = ""
                    var tempMoonset: String = ""
                    
                    if let sunrise = astro["sunrise"] as? String {
                        tempSunrise = sunrise
                    }
                    
                    if let sunset = astro["sunset"] as? String {
                        tempSunset = sunset
                    }
                    
                    if let moonrise = astro["moonrise"] as? String {
                        tempMoonrise = moonrise
                    }
                    
                    if let moonset = astro["moonset"] as? String {
                        tempMoonset = moonset
                    }
                    
                    tempAstro = Astro(sunrise: tempSunrise, sunset: tempSunset, moonrise: tempMoonrise, moonset: tempMoonset)
                }
                
                self.forecastday.append(Forecastday(date: tempDate, dateEpoch: tempDateEpoch, day: tempDay, astro: tempAstro))
            }
        }
    }
}

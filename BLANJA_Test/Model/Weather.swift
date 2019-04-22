//
//  Weather.swift
//  Gojek_Test
//
//  Created by Ernando Kasaluhe on 09/03/19.
//  Copyright © 2019 Ernando. All rights reserved.
//

import Foundation

final class Weather: NSObject {
    var location: Location?
    var current: CurrentWeather?
    var forecast: ForecastWeather?
    
    init?(dictionary: [String: Any]) {
        
        if let location = dictionary["location"] as? [String: Any] {
            self.location = Location(dictionary: location)
        }
        
        if let current = dictionary["current"] as? [String: Any] {
            self.current = CurrentWeather(dictionary: current)
        }
        
        if let forecast = dictionary["forecast"] as? [String: Any] {
            self.forecast = ForecastWeather(dictionary: forecast)
        }
    }
}

extension Weather: ResponseDataConvertible {
    convenience init?(rawData: Any) {
        
        if let dictionary = rawData as? [String: Any] {
            self.init(dictionary: dictionary)
        } else {
            return nil
        }
    }
}

//MARK: - Authentication
extension Weather {
    enum WeatherResult {
        case success(Weather)
        case failure(Error)
    }
    
    static func getWeather(withQ q: String,
                           withDays days: Int,
                           completionHandler: @escaping(WeatherResult) -> Void) {
       
        WeatherRequest(q: q, days: days).send() { result in
            
            switch result {
                
            case .success(let response):
                if let weather = response.resultData {
                    completionHandler(.success(weather))
                } else {
                    completionHandler(.failure(RequestError.invalidReturnedJSON))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}

//
//  WeatherRequest.swift
//  BLANJA_Test
//
//  Created by Ernando Kasaluhe on 20/04/19.
//  Copyright © 2019 Ernando Kasaluhe. All rights reserved.
//

import Foundation

struct WeatherRequest {
    let q: String
    let days: Int
}

extension WeatherRequest: Request {
    var baseURL: URL {
        return URL(fileURLWithPath: kAPIURL)
    }
    
    var path: String {
        return "/v1/forecast.json?key=5bc8e246f02844a394455029190903&q=\(q)&days=\(days)"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    typealias ResponseType = SingleDataResponse<Weather>
}

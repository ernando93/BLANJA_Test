//
//  GoogleSearchPlaceRequest.swift
//  BLANJA_Test
//
//  Created by Ernando Kasaluhe on 22/04/19.
//  Copyright © 2019 Ernando Kasaluhe. All rights reserved.
//

import Foundation

struct GoogleSearchPlaceRequest {
    let searchKey: String
}

extension GoogleSearchPlaceRequest: Request {
    var baseURL: URL {
        return URL(fileURLWithPath: "https://maps.googleapis.com")
    }
    
    var path: String {
        return "/maps/api/place/autocomplete/json?input=\(searchKey)&types=geocode&key=AIzaSyDjirnJmao0KWYkgvZvrJVeIFvD_tnZPVg"
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
    
   typealias ResponseType = SingleDataResponse<GooglePlacesAPI>
}

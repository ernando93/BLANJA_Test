//
//  GooglePlacesAPI.swift
//  BLANJA_Test
//
//  Created by Ernando Kasaluhe on 22/04/19.
//  Copyright © 2019 Ernando Kasaluhe. All rights reserved.
//

import Foundation

struct Prediction {
    let descriptionAPI: String
    let placeID: String
    let reference: String
    let mainText: String
    let secondaryText: String
}

final class GooglePlacesAPI: NSObject {
    let predictions: [Prediction]
    
    init?(dictionary: [String: Any]) {
        var tmpPredictions: [Prediction] = []
        
        if let prediction = dictionary["predictions"] as? [[String: Any]] {
            for data in prediction {
                var mainTextTemp = ""
                var secondaryTextTemp = ""
                
                if let structuredFormat = data["structured_formatting"] as? [String: Any] {
                    if let matchText = structuredFormat["main_text"] as? String {
                        mainTextTemp = matchText
                    } else {
                        mainTextTemp = data["description"] as! String
                    }
                    
                    if let matchText = structuredFormat["secondary_text"] as? String {
                        secondaryTextTemp = matchText
                    } else {
                        secondaryTextTemp = ""
                    }
                }
                
                tmpPredictions.append(Prediction(descriptionAPI: data["description"] as! String,
                                                 placeID: data["place_id"] as! String,
                                                 reference: data["reference"] as! String,
                                                 mainText: mainTextTemp,
                                                 secondaryText: secondaryTextTemp))
            }
            
            self.predictions = tmpPredictions
        } else {
            self.predictions = []
        }
    }
}

extension GooglePlacesAPI: ResponseDataConvertible {
    convenience init?(rawData: Any) {
        if let dictionary = rawData as? [String: Any] {
            self.init(dictionary: dictionary)
        } else {
            return nil
        }
    }
}

// MARK: - Autentication
extension GooglePlacesAPI {
    enum GooglePlacesAPIResult {
        case success(GooglePlacesAPI)
        case failure(Error)
    }
    
    static func searchPlaces(withSearchKey searchKey: String,
                             completionHandler: @escaping (GooglePlacesAPIResult) -> Void) {
        
        GoogleSearchPlaceRequest(searchKey: searchKey).send { result in
            switch result {
                
            case .success(let response):
                if let GooglePlacesAPI = response.resultData {
                    completionHandler(.success(GooglePlacesAPI))
                    
                } else {
                    completionHandler(.failure(RequestError.invalidReturnedJSON))
                }
                
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}

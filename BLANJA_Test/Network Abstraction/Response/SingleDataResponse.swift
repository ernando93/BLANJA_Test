//
//  SingleDataResponse.swift
//  BLANJA_Test
//
//  Created by Ernando Kasaluhe on 20/04/19.
//  Copyright © 2019 Ernando Kasaluhe. All rights reserved.
//

protocol ResponseDataConvertible {
    init?(rawData: Any)
}

struct SingleDataResponse<T: ResponseDataConvertible>: Response {
    let resultData: T?
    
    init?(json: Any) {
        self.resultData = T(rawData: json)
    }
    
}

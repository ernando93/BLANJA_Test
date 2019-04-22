//
//  Constant.swift
//  BLANJA_Test
//
//  Created by Ernando Kasaluhe on 22/04/19.
//  Copyright © 2019 Ernando Kasaluhe. All rights reserved.
//

import Foundation

let kAPIURL = Environment().configuration(PlistKey.ApiURL)

class Constant: NSObject {
    
    static func getDayNameBy(stringDate: String) -> String {
        let df  = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let date = df.date(from: stringDate)!
        df.dateFormat = "EEEE"
        return df.string(from: date);
    }
    
    static func stringFormat(withDouble double: Double) -> String {
        let stringText = String(format: "%.0f", double)
        
        return stringText
    }
}

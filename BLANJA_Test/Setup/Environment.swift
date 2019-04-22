//
//  Environment.swift
//  BLANJA_Test
//
//  Created by Ernando Kasaluhe on 22/04/19.
//  Copyright © 2019 Ernando Kasaluhe. All rights reserved.
//

import Foundation

public enum PlistKey {
    case ApiURL
    case ConnectionProtocol
    
    func value() -> String {
        switch self {
        case .ApiURL:
            return "api_url"
        case .ConnectionProtocol:
            return "protocol"
        }
    }
}
public struct Environment {
    
    fileprivate var infoDict: [String: Any]  {
        get {
            if let dict = Bundle.main.infoDictionary {
                return dict
            }else {
                fatalError("Plist file not found")
            }
        }
    }
    
    public func configuration(_ key: PlistKey) -> String {
        switch key {
        case .ApiURL:
            return infoDict[PlistKey.ApiURL.value()] as! String
        case .ConnectionProtocol:
            return infoDict[PlistKey.ConnectionProtocol.value()] as! String
        }
    }
}

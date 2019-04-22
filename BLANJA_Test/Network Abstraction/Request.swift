//
//  Request.swift
//  BLANJA_Test
//
//  Created by Ernando Kasaluhe on 20/04/19.
//  Copyright © 2019 Ernando Kasaluhe. All rights reserved.
//

import Alamofire

typealias ParameterEncoding = Alamofire.ParameterEncoding
typealias HTTPMethod = Alamofire.HTTPMethod

enum RequestError: Error {
    case networkFailure
    case invalidReturnedJSON
    case unknownError
}

enum RequestResult<T: Response> {
    case success(T)
    case failure(RequestError)
}

protocol Request {
    /// Full URL for the request
    ///
    /// For Example: http://www.google.com/search?q=jakarta
    var fullURL: URL { get }
    
    /// Base URL for the request
    ///
    /// For Example: http://www.google.com
    var baseURL: URL { get }
    
    /// Path to be placed after the base URL.
    ///
    /// For Example: /sktool
    var path: String { get }
    
    /// HTTP method for the request
    ///
    /// if not specified, it will use GET as default method.
    var method: HTTPMethod { get }
    
    // Parameter for the request.
    var parameters: [String: Any]? { get }
    
    /// Parameter encoding for the request
    ///
    /// if not specified, it will use 'URLEncoding.default'
    var parameterEncoding: ParameterEncoding { get }
    
    /// Header for the request
    ///
    /// if not specified, it will not use for header
    var headers: [String: String]? { get }
    
    /// The response type for the request
    ///
    /// - Note: The response type for the request must conform 'Response' protocol
    associatedtype ResponseType: Response
    
    /// Send request to the complete URL specified in 'BaseURL' and 'path' variable.
    ///
    /// Tis method will use 'baseURL', 'Path' , 'method', 'parameters', 'parameterEncoding'
    /// 'header' to construct the request.
    ///
    /// - Parameter completionHandler: A closure that will be called upon successfull or failed request.
    func send(usingCompletionHandler completionHandler: @escaping (RequestResult<ResponseType>) -> Void)
}

// MARK: - Default
extension Request {
    var fullURL: URL {
        if let parameters = parameters {
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
            urlComponents.queryItems = parameters.map {
                URLQueryItem(name: $0.key, value: "\($0.value)")
            }
        }
        
        return url
    }
    
    var url: URL {
        return baseURL.appendingPathComponent(path)
    }
    
    var method: HTTPMethod {
        return method
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var headers: [String: String]? {
        return headers
    }
    
    func send(usingCompletionHandler completionHandler: @escaping (RequestResult<ResponseType>) -> Void) {
        
        let newURL = fullURL.absoluteString.removingPercentEncoding
        
        let dataRequest = Alamofire.request(newURL!, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers)

        dataRequest.responseJSON { response in
            switch response.result {

            case .success(let responseValue):
                if let theResponse = ResponseType(json: responseValue) {
                    completionHandler(RequestResult<ResponseType>.success(theResponse))
                } else {
                    completionHandler(RequestResult.failure(.invalidReturnedJSON))
                }
            case .failure(let error):
                if let error = error as? AFError {
                    switch error {
                    case .responseSerializationFailed(reason: _):
                        completionHandler(RequestResult.failure(.invalidReturnedJSON))
                    default:
                        completionHandler(RequestResult.failure(.unknownError))
                    }
                } else {
                    let error = error as NSError
                    if error.domain == NSURLErrorDomain {
                        completionHandler(RequestResult.failure(.networkFailure))
                    } else {
                        completionHandler(RequestResult.failure(.unknownError))
                    }
                }
            }
        }
    }
}

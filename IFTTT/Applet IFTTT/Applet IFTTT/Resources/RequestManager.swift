//
//  RequestManager.swift
//  Applet IFTTT
//
//  Created by Alexa Francis on 9/17/19.
//  Copyright © 2019 Alexa Francis. All rights reserved.
//

import Foundation
import Alamofire

extension DataResponse {
    public func nonGenericResponse() -> DefaultDataResponse {
        return DefaultDataResponse(request: self.request, response: self.response, data: self.data, error: self.error, timeline: self.timeline, metrics: self.metrics)
    }
}

public enum RequestHeaders: String {
    case appID = "app-id"
    case deviceLocale = "device-locale"
    case storeNumber = "store-number"
    case serverToken = "Authorization"
    case mediaType = "media-type"
    case txnid = "txn-id"
    case timestamp = "timestamp"
    case flow = "flow"
}

public class RequestManager: Alamofire.SessionManager {

    private struct Constant {
        static let jwtTokenResponseHeaderKey: String = "Authorization"
    }
    
    // Defaults
    private struct Defaults {
        static let serverProtocol = "http"
        static let serverHostname = "example.com"
        static let serverServicesPath = "/ExampleService/v1"
        static let requestTimeoutInSec = 20
    }
    
    /// various values that we cache from the config file
    private(set) static var serverProtocol: String        = Defaults.serverProtocol
    private(set) static var serverHostname: String        = Defaults.serverHostname
    private(set) static var serverServicesPath: String    = Defaults.serverServicesPath
    private(set) static var requestTimeoutInSec: Int    = Defaults.requestTimeoutInSec
    
    /// computed property which constructs the server's base url (so that the endpoint can be tacked onto the end)
    public static var serverBaseUrl: String {
        let url = "\(RequestManager.serverProtocol)://\(RequestManager.serverHostname)\(RequestManager.serverServicesPath)"
        assert(URL(string: url) != nil, "Invalid server url: \(url)")
        return url
    }
    
    public init(skipAuthenticator: Bool = false) {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.requestCachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        // How long to wait for additional data before giving up. Whenever new data arrives, this timer is reset. Default is 60 sec.
        configuration.timeoutIntervalForRequest = TimeInterval(RequestManager.requestTimeoutInSec)
        // How long to wait for an entire resource to transfer before giving up. Default is 7 days.
        configuration.timeoutIntervalForResource = TimeInterval(RequestManager.requestTimeoutInSec)
        
        
        // Note: Once Alamofire.Manager creates a NSURLSession with the given configuration, it is not possible to change the configuration and have those changes take effect.
        // A new Alamofire.Manager instance must be created in order to change the configuration.
        super.init(configuration: configuration, serverTrustPolicyManager: nil)
        
    }

    public func jsonRequest(_ url: URLRequestConvertible, completion: @escaping ([String: Any], [AnyHashable:Any]?) -> Void) {
        request(url)
        
        self.request(url) {
            completion(request.ifSuccess())
            request.validate().responseJSON { (response) in
                let result: [String: Any]
                completion(result, response.response?.allHeaderFields)
            }
        }
    }
    
//    public func objectRequest<T: Decodable>(_ url: URLConvertible, keyPath: String? = nil, completion: @escaping (FargoCore.Result<T>, String?) -> Void) {
//        self.request(url) { (request) in
//
//            request.validate(statusCode: Set(200..<300).subtracting(Set([204, 209]))).responseObject(keyPath: keyPath) { (response: DataResponse<T>) in
//                let result: FargoCore.Result<T>
//
//                let jwtToken = response.response?.allHeaderFields[Constant.jwtTokenResponseHeaderKey] as? String
//
//                if let error = response.result.error {
//                    let serverError = RequestManager.extractServerError(response.data) ?? error
//                    result = .failure(RequestError(underlyingError: serverError, response: response.nonGenericResponse()))
//                } else if let value = response.result.value {
//                    result = .success(value)
//                } else {
//                    let underlyingError = SpecificRequestError.invalidResponse("Failed to cast response to 'Decodable' model")
//                    result = .failure(RequestError(underlyingError: underlyingError, response: response.nonGenericResponse()))
//                }
//
//                completion(result, jwtToken)
//            }
//        }
//    }

}

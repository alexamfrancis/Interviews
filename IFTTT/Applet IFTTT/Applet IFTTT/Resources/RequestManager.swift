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
    open func request(_ url: URLRequestConvertible, completion: @escaping (Alamofire.DataRequest) -> Void)

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
    
    public override func request(_ urlRequest: URLRequestConvertible) -> DataRequest {
        urlRequest.validate().responseData(completionHandler: { [weak self] response in
            guard let self = self else { return }
            
            self.reauthIfRequired(with: response, retryRequestBlock: { [weak self] in
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    self.request(url, completion: completion)
                }
            })
        }
    }
    
    public func jsonRequest(_ url: URLRequestConvertible, completion: @escaping ([String: Any], [AnyHashable:Any]?) -> Void) {
        self.request(url) { (request) in
            
            request.validate().responseJSON { (response) in
                let result: FargoCore.Result<[String: Any]>
                
                if let serverError = RequestManager.extractServerError(response.data) {
                    result = .failure(RequestError(underlyingError: serverError, response: response.nonGenericResponse()))
                } else if let error = response.result.error {
                    result = .failure(RequestError(underlyingError: error, response: response.nonGenericResponse()))
                } else if let value = response.result.value as? [String: Any] {
                    result = .success(value)
                } else {
                    let underlyingError = SpecificRequestError.invalidResponse("Failed to cast response to 'ServerResponseType'")
                    result = .failure(RequestError(underlyingError: underlyingError, response: response.nonGenericResponse()))
                }
                
                completion(result, response.response?.allHeaderFields)
            }
        }
    }
    
    /// A convenient way to call `RequestManager.request()` and get the result in a wrapped success-with-data-or-failure-with-error type.
    ///
    /// This function expects the given url to return a 'no content' response (i.e. a 204 HTTP status code).
    ///
    /// The following steps are performed:
    /// 1. Calls `RequestManager.request`.
    /// 2. Wraps an 'empty' success - or error, if any - in a `Result`.
    public func dataRequest(_ url: URLRequestConvertible, completion: @escaping (FargoCore.Result<Void>) -> Void) {
        self.request(url) { (request) in
            
            request.validate().responseData { (response) in
                let result: FargoCore.Result<Void>
                
                if let error = response.result.error {
                    let serverError = RequestManager.extractServerError(response.data) ?? error
                    result = .failure(RequestError(underlyingError: serverError, response: response.nonGenericResponse()))
                } else {
                    result = .success(())
                }
                
                completion(result)
            }
        }
    }
    
    /// A convenient way to call `RequestManager.request()` and get a result in a wraper success-with-data-or-failre-with-error type.
    ///
    ///    This function expects the given url to return a Data object which will then be converted to a `Decodable` object.
    ///
    /// - Parameters:
    ///   - url: URLRequest
    ///      - keyPath: keyPath to extract the objects from in the response. Defaults to nil
    ///   - completion: completion with `FargoCore.Result` and an optional String representing the JWTToken included
    ///                 in the repsonse header.
    public func objectRequest<T: Decodable>(_ url: URLRequestConvertible, keyPath: String? = nil, completion: @escaping (FargoCore.Result<T>, String?) -> Void) {
        self.request(url) { (request) in
            
            request.validate(statusCode: Set(200..<300).subtracting(Set([204, 209]))).responseObject(keyPath: keyPath) { (response: DataResponse<T>) in
                let result: FargoCore.Result<T>
                
                let jwtToken = response.response?.allHeaderFields[Constant.jwtTokenResponseHeaderKey] as? String
                
                if let error = response.result.error {
                    let serverError = RequestManager.extractServerError(response.data) ?? error
                    result = .failure(RequestError(underlyingError: serverError, response: response.nonGenericResponse()))
                } else if let value = response.result.value {
                    result = .success(value)
                } else {
                    let underlyingError = SpecificRequestError.invalidResponse("Failed to cast response to 'Decodable' model")
                    result = .failure(RequestError(underlyingError: underlyingError, response: response.nonGenericResponse()))
                }
                
                completion(result, jwtToken)
            }
        }
    }
    
    /// A convenient way to call `RequestManager.request()` and get a result in a wraper success-with-data-or-failre-with-error type.
    ///
    ///    This function expects the given url to return a Data object which will then be converted to an Array of `Decodable` object.
    /// This function expects the given url to return a message key and message response (i.e. a 209 HTTP status code).
    
    /// - Parameters:
    ///   - url: URLRequest
    ///      - keyPath: keyPath to extract the objects from in the response. Defaults to nil
    ///   - completion: completion with `FargoCore.Result` and an optional String representing the JWTToken included
    ///                 in the repsonse header.
    public func objectRequest<T: Decodable>(_ url: URLRequestConvertible, keyPath: String? = nil, completion: @escaping (FargoCore.Result<[T]>, String?) -> Void) {
        self.request(url) { (request) in
            
            request.validate(statusCode: Set(200..<300).subtracting(Set([209]))).responseObject(keyPath: keyPath) { (response: DataResponse<[T]>) in
                let result: FargoCore.Result<[T]>
                
                let jwtToken = response.response?.allHeaderFields[Constant.jwtTokenResponseHeaderKey] as? String
                
                if let error = response.result.error {
                    let serverError = RequestManager.extractServerError(response.data) ?? error
                    result = .failure(RequestError(underlyingError: serverError, response: response.nonGenericResponse()))
                } else if let value = response.result.value {
                    result = .success(value)
                } else {
                    let underlyingError = SpecificRequestError.invalidResponse("Failed to cast response to 'Decodobale' model")
                    result = .failure(RequestError(underlyingError: underlyingError, response: response.nonGenericResponse()))
                }
                
                completion(result, jwtToken)
            }
        }
    }
    
    //MARK: - Helper methods
    
    /// Extracts the server error from the original response data if it exists
    ///
    /// - Parameter response: original response
    /// - Returns: RequestError.serverErrors with an array of errors, or nil
    public class func extractServerError(_ responseData: Data?) -> Error? {
        
        // First look for a single root level error object
        if let data = responseData, let jsonObject = JSON.dataToJSONObject(data) as? [String: Any], let serverError = serverError(fromDictionary: jsonObject) {
            // Create an array with the single root level error object we found
            return SpecificRequestError.serverErrors([serverError])
            // Then look for an some message keys for http code 209 in response
        } else if let data = responseData, let jsonObject = JSON.dataToJSONObject(data) as? [String: Any], let serverError = serverMessageForEmptyResponse(fromDictionary: jsonObject) {
            return SpecificRequestError.serverErrors([serverError])
            // Then look for an "errorDetails" array at the root level that contains dictionaries
        } else if let data = responseData, let jsonObject = JSON.dataToJSONObject(data) as? [String: Any], let errorDetails = jsonObject["errorDetails"] as? [[String: Any]] {
            
            // Extract all errors from the error details array
            let errors = errorDetails.compactMap({ serverError(fromDictionary: $0) })
            
            // Return nil if we find no errors
            guard !errors.isEmpty else { return nil }
            
            // Otherwise put them all into a server error object
            return SpecificRequestError.serverErrors(errors)
            // This final check is for certain errors delievered to us as an array of [String: Any] dictionaries. The
            // errorCode and errorMessage fields are of particular importance.
        } else if let data = responseData, let jsonArray = JSON.dataToJSONObject(data) as? [Any?], !jsonArray.isEmpty {
            
            if let jsonDictionary = jsonArray[0] as? [String: String], let errorCode: String = jsonDictionary["errorCode"] {
                return ServerError(code: errorCode, message: jsonDictionary["errorMessage"])
            }
            
            
        }
        
        // Default
        return nil
    }
    
    /// Extracts a server error from a JSON dictionary
    ///
    /// - Parameter dictionary: dictionary in which to look for the error code and message for the error
    /// - Returns: ServerError or nil
    private class func serverError(fromDictionary dictionary: [String: Any]) -> ServerError? {
        
        // Require an errorCode. If we don't find one then exit early.
        guard let serverErrorCode = dictionary["errorKey"] as? String else { return nil }
        
        // Optional message param only used for logging
        let serverDebugErrorMessage = dictionary["message"] as? String
        Log.debug(serverDebugErrorMessage ?? serverErrorCode)
        
        // Return the ServerError object
        return ServerError(code: serverErrorCode, message: serverDebugErrorMessage)
    }
    
    /// Extracts a server message from a JSON dictionary in case of 209
    ///
    /// - Parameter dictionary: dictionary in which to look for the message key and message from the error
    /// - Returns: ServerError or nil
    private class func serverMessageForEmptyResponse(fromDictionary dictionary: [String: Any]) -> ServerError? {
        
        // Requires a message key. If we don't find one then exit early.
        guard let serverMessageKey = dictionary["messageKey"] as? String else { return nil }
        let serverMessage = dictionary["message"] as? String
        
        // Return the ServerError object
        return ServerError(code: serverMessageKey, message: serverMessage)
    }
    
    private func reauthIfRequired<T>(with response: DataResponse<T>, retryRequestBlock: () -> Void) {
        var shouldFireReauth = false
        
        // If sos bridge throws unauthorized error, perform reauth again
        if let serverError = RequestManager.extractServerError(response.data) as? RequestError, serverError.errorDescription == "Error.Unauthorized" {
            shouldFireReauth = true
        }
        
        // When the status code is 401 - token expired error, perform reauth again
        if let statusCode = response.response?.statusCode, statusCode == 401 {
            shouldFireReauth = true
        }
        
        guard shouldFireReauth else { return }
        
        // Token expired, so let's fire a refreshToken request
        Log.info("Service token expired. Firing refreshToken...")
        
        // First let's set the user to nil
        Authenticator.shared.user = nil
        
        // Now let's fire the last request again. This will trigger the refreshToken automaticaly
        Log.info("Dispatching the last request which received a 401/403 again...")
        retryRequestBlock()
    }
    
    private func onEnvironmentDidChange(notification: Notification) {
        // update the base url
        self.configureBaseUrl()
    }
}

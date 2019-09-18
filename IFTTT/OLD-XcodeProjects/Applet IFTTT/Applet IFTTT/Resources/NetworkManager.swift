//
//  NetworkManager.swift
//  Applet IFTTT
//
//  Created by Alexa Francis on 9/17/19.
//  Copyright © 2019 Alexa Francis. All rights reserved.
//

import Foundation
import Alamofire

open class NetworkManager : Alamofire.SessionManager {
    
    weak public private(set) var authenticator: RequestAuthenticator? {
        get
    }
    
    public var logger: FargoNetwork.NetworkLogger?
    
    public func setupAuthenticator(_ authenticator: RequestAuthenticator)
    
    open func request(_ url: URLRequestConvertible, completion: @escaping (Alamofire.DataRequest) -> Void)
    
    open func download(_ urlRequest: URLRequestConvertible, to destination: Alamofire.DownloadRequest.DownloadFileDestination?, completion: @escaping (Alamofire.DownloadRequest) -> Void)
    
    open func upload(_ data: Data, with urlRequest: URLRequestConvertible, completion: @escaping (Alamofire.UploadRequest) -> Void)
}

//
//  ServerRequest.swift
//  Zap-Challenge
//
//  Created by Michael Douglas on 08/02/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

//**********************************************************************************************************
//
// MARK: - Definitions -
//
//**********************************************************************************************************

public typealias LogicResult = (ServerResponse) -> Void
public typealias ServerResult = (JSON, ServerResponse) -> Void

/**
 Defines how the main server defines its responses.
 Showing up the agreed error codes and messages for each of the known scenarios.
 */
public enum ServerResponse {
  
  public enum Error: String {
    case unkown = "ST_SERVER_ERROR"
    case serviceUnavailable = "ST_SERVICE_UNAVAILABLE"
    case noConnection = "ST_NO_CONNECTION"
  }
  
  case success
  case error(ServerResponse.Error)
  
  //**************************************************
  // MARK: - Properties
  //**************************************************
  
  public var localizedError: String {
    switch self {
    case .error(let type):
      return type.rawValue.localized
    default:
      return ""
    }
  }
  
  //**************************************************
  // MARK: - Initializers
  //**************************************************
  
  public init(_ response: HTTPURLResponse?) {
    if let httpResponse = response {
      switch httpResponse.statusCode {
      case 200..<300:
        self = .success
      case 503:
        self = .error(.serviceUnavailable)
      default:
        self = .error(.unkown)
      }
    } else if NetworkReachabilityManager()?.isReachable == false {
      self = .error(.noConnection)
    } else {
      self = .error(.unkown)
    }
  }
}

//**********************************************************************************************************
//
// MARK: - Type -
//
//**********************************************************************************************************

public enum ServerRequest {
  
  case mobile(RESTContract)
  
  public typealias RESTContract = (method: HTTPMethod, path: String)
  
  public struct API {
    static public var mobile: String = API.v5
    static public let client_id: String = "6g29n37tfz2cxsgvogs3xhearpeqaa"

    static public let v5: String = "https://api.twitch.tv/kraken"
  }
  
  public struct Games {
    static public func top(with limit: Int, from offset: Int) -> ServerRequest {
      return .mobile((method: .get, path: "/games/top?limit=\(limit)&offset=\(offset)"))
    }
  }
  
  //**************************************************
  // MARK: - Protected Methods
  //**************************************************
  
  private func getHeader() -> HTTPHeaders {
    var headers = Alamofire.SessionManager.defaultHTTPHeaders
    headers["Accept"] = "application/vnd.twitchtv.v5+json"
    headers["Client-ID"] = "\(API.client_id)"
    return headers
  }
  
  //**************************************************
  // MARK: - Exposed Methods
  //**************************************************
  
  public var method: HTTPMethod {
    switch self {
    case .mobile(let contract):
      return contract.method
    }
  }
  
  public var path: String {
    switch self {
    case .mobile(let contract):
      return ServerRequest.API.mobile + contract.path
    }
  }
  
  /// This method is used to Execute Requests
  ///
  /// - Parameters:
  ///   - aPath: Custom Path for your Request.
  ///   - params: Params of your Request
  ///   - completion: This method produces (JSON, ServerResponse) -> Void
  public func execute(aPath: String? = nil,
                      params: [String: Any]? = nil,
                      completion: @escaping ServerResult) {
    DispatchQueue.global(qos: .background).async {
      
      let method = self.method
      let finalPath = aPath ?? self.path
      let closure = { (_ dataResponse: DataResponse<Any>) in
        
        var json: JSON = [:]
        
        ServerLogger.logResponse(dataResponse.response, data: dataResponse.data)
        
        switch dataResponse.result {
        case .success(let data):
          json = JSON(data)
        default:
          break
        }
        
        completion(json, ServerResponse(dataResponse.response))
      }
      
      let headers = self.getHeader()
      
      if let request = Alamofire.request(finalPath,
                            method: method,
                            parameters: params,
                            encoding: JSONEncoding.default,
                            headers: headers).responseJSON(completionHandler: closure).request {
        ServerLogger.logRequest(request)
      }
    }
  }
}


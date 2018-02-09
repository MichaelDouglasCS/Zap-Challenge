//
//  ServerLogger.swift
//  Zap-Challenge
//
//  Created by Michael Douglas on 08/02/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import Foundation
import SwiftyJSON

//**********************************************************************************************************
//
// MARK: - Class -
//
//**********************************************************************************************************

public class ServerLogger: NSObject {
  
  //*************************************************
  // MARK: - Exposed Methods
  //*************************************************
  
  public class func logSeparator() {
    print("----------------------------------//----------------------------------")
  }
  
  public class func logHeaders(_ headers: [String: AnyObject]) {
    print("Headers: [")
    for (key, value) in headers {
      print("  \(key) : \(value)")
    }
    print("]")
  }
  
  public class func logValue<Value>(_ value: Value) {
    print("📦 Value from Response:")
    print("\(value)")
  }
  
  public class func logSuccess() {
    print("📦 Success!")
  }
  
  public class func logError(_ error: NSError?) {
    self.logSeparator()
    
    if let error = error {
      print("⚠️ Error: \(error.localizedDescription)")
      
      if let reason = error.localizedFailureReason {
        print("Reason: \(reason)")
      }
      
      if let suggestion = error.localizedRecoverySuggestion {
        print("Suggestion: \(suggestion)")
      }
    } else {
      print("⚠️ Error: nil")
    }
  }
  
  public class func logRequest(_ request: URLRequest) {
    self.logSeparator()
    
    if let url = request.url?.absoluteString {
      print("📤 Request: \(request.httpMethod!) \(url)")
    }
    
    if let headers = request.allHTTPHeaderFields {
      self.logHeaders(headers as [String: AnyObject])
    }
    
    if let httpBody = request.httpBody {
      do {
        let json = try JSONSerialization.jsonObject(with: httpBody, options: .allowFragments)
        let pretty = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        
        if let string = NSString(data: pretty, encoding: String.Encoding.utf8.rawValue) {
          print("JSON: \(string)")
        }
      } catch {
        if let string = NSString(data: httpBody, encoding: String.Encoding.utf8.rawValue) {
          print("Data: \(string)")
        }
      }
    }
  }
  
  public class func logResponse(_ response: URLResponse?, data: Data? = nil) {
    self.logSeparator()
    
    if let response = response {
      
      if let url = response.url?.absoluteString {
        print("📥 Response: \(url)")
      }
      
      if let httpResponse = response as? HTTPURLResponse {
        let localisedStatus = HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode).capitalized
        print("Status: \(httpResponse.statusCode) - \(localisedStatus)")
      }
      
      if let headers = (response as? HTTPURLResponse)?.allHeaderFields as? [String: AnyObject] {
        self.logHeaders(headers)
      }
      
      guard let data = data else { return }
      
      do {
        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        if let theJson = json as? JSON {
          let pretty = try JSONSerialization.data(withJSONObject: theJson, options: .prettyPrinted)
          if let string = NSString(data: pretty, encoding: String.Encoding.utf8.rawValue) {
            print("JSON: \(string)")
          }
        } else {
          if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
            print("Data: \(string)")
          }
        }
        
      } catch {
        if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
          print("Data: \(string)")
        }
      }
      
    } else {
      print("📥 Response: nil ")
    }
  }
}

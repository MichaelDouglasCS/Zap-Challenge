//
//  KeychainService.swift
//  Zap-Challenge
//
//  Created by Michael Douglas on 13/02/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import Foundation
import KeychainAccess

//**********************************************************************************************************
//
// MARK: - Class -
//
//**********************************************************************************************************

public final class KeychainService: NSObject {
    
    //*************************************************
    // MARK: - Properties
    //*************************************************
    
    private lazy var keychain: Keychain = Keychain(service: Bundle.main.bundleIdentifier ?? "com.michaeldouglas.Zap-Challenge")
    
    //*************************************************
    // MARK: - Initializers
    //*************************************************
    
    private override init() { }
    
    public static let shared: KeychainService = {
        return KeychainService()
    }()
    
    //*************************************************
    // MARK: - Exposed Methods
    //*************************************************
    
    public func setValue(_ value: String, forKey key: String) {
        do { try keychain.set(value, key: key) } catch { }
    }
    
    public func getValue(forKey key: String) -> String? {
        do { return try self.keychain.getString(key) } catch { return nil }
    }
    
    public func removeValue(forKey key: String) {
        do { try keychain.remove(key) } catch { }
    }
    
    public func clearAll() {
        do { try keychain.removeAll() } catch { }
    }
}

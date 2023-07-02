//
//  KeychainManager.swift
//  Checker2
//
//  Created by bmtech on 22.03.2023.
//

import Foundation

//final class KeychainManager {
//    private let server = "www.test.com"
//
//    private init() {}
//
//    static let shared = KeychainManager()
//
//    func storeCredentials(credentials: Credentials) throws {
//        let account = credentials.username
//        guard let password = credentials.password.data(using: String.Encoding.utf8) else {
//            throw KeychainError.unexpectedPasswordData
//        }
//
//        let query: [String: AnyObject] = [
//            kSecAttrService as String: server as AnyObject,
//            kSecAttrAccount as String: account as AnyObject,
//            kSecClass as String: kSecClassGenericPassword,
//            kSecValueData as String: password as AnyObject
//        ]
//
//        let status = SecItemAdd(query as CFDictionary, nil)
//        guard status == errSecSuccess else {
//            print("status: \(status)")
//            throw KeychainError.unhandledError(status: status)
//        }
//    }
//
//    func getStoredCredentials(forIdentifier: String) throws -> String {
//        let query: [String: AnyObject] = [
//            kSecAttrService as String: server as AnyObject,// standart key
//            kSecAttrAccount as String: forIdentifier as AnyObject, // account
//            kSecClass as String: kSecClassGenericPassword, //
//            kSecMatchLimit as String: kSecMatchLimitOne,
//            kSecReturnData as String: kCFBooleanTrue
//        ]
//
//        var item: CFTypeRef?
//        let status = SecItemCopyMatching(query as CFDictionary, &item)
//        guard status != errSecItemNotFound else {
//            throw KeychainError.noPassword
//        }
//
//        guard status == errSecSuccess else {
//            throw KeychainError.unhandledError(status: status)
//        }
//
//        guard let passwordData = item as? Data,
//              let password = String(data: passwordData, encoding: String.Encoding.utf8)
//        else {
//            throw KeychainError.unexpectedPasswordData
//        }
//        return password
//    }
//}

class KeychainManager {
    enum KeychainError: Error {
        case duplicateEntry
        case unknown(OSStatus)
    }
    
    static func save(
        service: String,
        account: String,
        password: Data
    ) throws {
    print("starting save...")
        //service, account, password, class, data
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecValueData as String: password as AnyObject,
        ]
        
        let status = SecItemAdd(
            query as CFDictionary, nil
        )
        
        guard status != errSecDuplicateItem else {
            throw KeychainError.duplicateEntry
        }
        
        guard status == errSecSuccess else {
            throw KeychainError.unknown(status)
        }
        
        print("saved")
    }
    
    static func get(
        service: String,
        account: String
    ) -> Data? {
    print("starting save...")
        //service, account, password, class,
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecReturnData as String: kCFBooleanTrue,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(
            query as CFDictionary,
            &result
        )
        
        print("Read status: \(status)")
       return result as? Data
    }
}


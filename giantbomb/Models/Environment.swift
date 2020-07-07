// Environment.swift

import Foundation

public enum Environment {
    static let gbApiKeyIdentifier = "gb_api_key"

    // MARK: - Keys
    enum Keys {
        enum Plist {
            static let gbApiUrl = "GB_API_URL"
            static let gbApiKey = "GB_API_KEY"
        }
    }

    // MARK: - Plist
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()

    // MARK: - Plist values
    static let gbApiUrl: String = {
        guard let gbApiUrlString = Environment.infoDictionary[Keys.Plist.gbApiUrl] as? String else {
            fatalError("GB_API_URL not set")
        }
        return gbApiUrlString
    }()

    static let gbApiKey: String = {
        guard let gbApiKey = Environment.infoDictionary[Keys.Plist.gbApiKey] as? String else {
            fatalError("GB_API_Key not set in plist for this environment")
        }
        return gbApiKey
    }()
}


//enum KeychainError: Error {
//    case noPassword
//    case duplicateItem
//    case parseError
//    case unhandledError(status: OSStatus)
//}

class KeychainStore {
    private static let service = "gbtv_app"

    static func saveValue(key: String, value: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecReturnAttributes as String: kCFBooleanTrue!,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key,
            kSecValueData as String: value.data(using: String.Encoding.utf8)!
        ]

        let writeStatus = SecItemAdd(query as CFDictionary, nil)

        if writeStatus == errSecDuplicateItem {
            return print("Save Failed - Duplicate Item")
        }
        if writeStatus != errSecSuccess {
            return print("Save Failed - write error \(writeStatus)")
        }

        print("Save Success - \(key)")
    }

    static func getValue(key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecReturnAttributes as String: kCFBooleanTrue!,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key,
        ]

        var queryResult: AnyObject?
        let readStatus = SecItemCopyMatching(query as CFDictionary, &queryResult)

        if readStatus == errSecItemNotFound {
            print("Get Failed - Not Found \(readStatus)")
            return nil
        }
        if readStatus != errSecSuccess {
            print("Get Failed - Read error \(readStatus)")
            return nil
        }

        guard let result = queryResult as? [String : Any],
            let valueData = result[kSecValueData as String] as? Data,
            let value = String(data: valueData, encoding: String.Encoding.utf8)
            else {
                print("Get Failed - Parse error \(readStatus)")
                return nil
        }

        print("Get Success - \(value)")
        return value
    }

    static func deleteValue(key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecReturnAttributes as String: kCFBooleanTrue!,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key,
        ]

        let deleteStatus = SecItemDelete(query as CFDictionary)

        if !(deleteStatus == errSecSuccess || deleteStatus == errSecItemNotFound) {
            return print("Delete Failed \(deleteStatus)")
        }

        print("Delete Success")
    }

    static func updateValue(key: String, value: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key,
        ]
        let updateAttributes: [String: Any] = [
            kSecValueData as String: value.data(using: String.Encoding.utf8)!
        ]

        let updateStatus = SecItemUpdate(query as CFDictionary, updateAttributes as CFDictionary)

        if updateStatus != errSecSuccess {
            return print("Update Failed - write error \(updateStatus)")
        }

        print("Update Success - \(key)")
    }
}

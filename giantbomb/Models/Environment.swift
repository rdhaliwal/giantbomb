// Environment.swift

import Foundation

public enum Environment {
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
        print(writeStatus)
        if writeStatus == errSecDuplicateItem {
            return print("Already exists in Keychain. Use update instead of save")
        }
        if writeStatus != errSecSuccess {
            return print("Failed to Save")
        }

        print("saveValue success - \(key)")
    }

    static func getValue(key: String) -> String{
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecReturnAttributes as String: kCFBooleanTrue!,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key,
        ]

        var queryResult: AnyObject?
        let readStatus = SecItemCopyMatching(query as CFDictionary, &queryResult)

        print(readStatus)

        if readStatus != errSecSuccess {
            print("Failed to Read")
            return "Nope - Read error"
        }

        guard let result = queryResult as? [String : Any],
            let valueData = result[kSecValueData as String] as? Data,
            let value = String(data: valueData, encoding: String.Encoding.utf8)
            else { return "Nope - Parse error" }

        print("getValue success - \(value)")
        return value
    }

    /*
    static func updateValue(key: String, value: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecReturnAttributes as String: kCFBooleanTrue!,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key,
            kSecValueData as String: value.data(using: String.Encoding.utf8)!
        ]

        let writeStatus = SecItemAdd(query as CFDictionary, nil)
        print(writeStatus)
        if writeStatus == errSecDuplicateItem {
            return print("Already exists in Keychain. Use update instead of save")
        }
        if writeStatus != errSecSuccess {
            return print("Failed to Save")
        }

        print("saveValue success - \(key)")
    }
 */
}

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

//
//  CacheManager.swift
//  CookingRecipe
//
//  Created by Jacob Wheeler on 11/5/25.
//

import Foundation

class CacheManager {
    static let shared = CacheManager()
    private init() {}
    
    private let cacheFolder: URL = {
        let folder = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let path = folder.appendingPathComponent("MealCache")
        try? FileManager.default.createDirectory(at: path, withIntermediateDirectories: true)
        return path
    }()
    
    func save<T: Encodable>(_ data: T, forKey key: String) {
        let fileURL = cacheFolder.appendingPathComponent("\(key).json")
        do {
            let encoded = try JSONEncoder().encode(data)
            try encoded.write(to: fileURL)
        } catch {
            print("Cache save failed for key \(key): \(error)")
        }
    }
    
    func load<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        let fileURL = cacheFolder.appendingPathComponent("\(key).json")
        guard FileManager.default.fileExists(atPath: fileURL.path) else { return nil }
        do {
            let data = try Data(contentsOf: fileURL)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("Cache load failed for key \(key): \(error)")
            return nil
        }
    }
    
    func isCacheValid(forKey key: String, maxAge: TimeInterval = 86400) -> Bool {
        let fileURL = cacheFolder.appendingPathComponent("\(key).json")
        guard let attrs = try? FileManager.default.attributesOfItem(atPath: fileURL.path),
              let modDate = attrs[.modificationDate] as? Date else {
            return false
        }
        return abs(modDate.timeIntervalSinceNow) < maxAge
    }
}

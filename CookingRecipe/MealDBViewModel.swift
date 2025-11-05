//
//  MealDBViewModel.swift
//  CookingRecipe
//
//  Created by Jacob Wheeler on 10/3/25.
//

import Foundation

class MealDBAPI {
    static func fetch<T: Codable>(
        url: String,
        decodeType: T.Type,
        cacheKey: String,
        maxAge: TimeInterval = 86400, // default: 24 hours
        completion: @escaping (T?) -> Void
    ) {
        let cache = CacheManager.shared
        
        if cache.isCacheValid(forKey: cacheKey, maxAge: maxAge),
           let cached: T = cache.load(T.self, forKey: cacheKey) {
            print("Loaded from cache: \(cacheKey)")
            completion(cached)
            return
        }
        
        guard let url = URL(string: url) else { return }
        print("Fetching fresh data for: \(cacheKey)")
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                print("Network error, fallback to cache if available")
                if let cached: T = cache.load(T.self, forKey: cacheKey) {
                    DispatchQueue.main.async { completion(cached) }
                }
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(decodeType, from: data)
                DispatchQueue.main.async {
                    completion(decoded)
                }
                cache.save(decoded, forKey: cacheKey)
                print("Cached new data for: \(cacheKey)")
            } catch {
                print("Decode error: \(error)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
}

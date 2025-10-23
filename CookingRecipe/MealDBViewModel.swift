//
//  MealDBViewModel.swift
//  CookingRecipe
//
//  Created by Jacob Wheeler on 10/3/25.
//

import Foundation

class MealDBAPI {
    static func fetch<T: Decodable>(url: String, decodeType: T.Type, completion: @escaping (T?) -> Void) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                let decoder = JSONDecoder()
                if let decoded = try? decoder.decode(decodeType, from: data) {
                    DispatchQueue.main.async { completion(decoded) }
                } else {
                    DispatchQueue.main.async { completion(nil) }
                }
            }
        }.resume()
    }
}


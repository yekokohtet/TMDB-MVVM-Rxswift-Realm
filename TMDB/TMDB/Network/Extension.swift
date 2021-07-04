//
//  Extension.swift
//  TMDB
//
//  Created by Ye Ko on 02/07/2021.
//

import Foundation

extension Data {
    func serializeData<T>(for object: T.Type) -> T where T: Codable {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try! decoder.decode(object, from: self)
    }
}


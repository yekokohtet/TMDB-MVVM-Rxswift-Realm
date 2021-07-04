//
//  Error.swift
//  TMDB
//
//  Created by Ye Ko on 02/07/2021.
//

import Foundation

struct Error: Codable {
    var message: String?
    var statusCode: Int?
}

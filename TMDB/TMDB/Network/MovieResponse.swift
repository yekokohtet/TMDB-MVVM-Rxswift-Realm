//
//  MovieResponse.swift
//  TMDB
//
//  Created by Ye Ko on 02/07/2021.
//

import Foundation

class UpcomingResponse: Codable {
    var totalPages: Int?
    var results: [UpcomingMovieVO] = []
}

class PopularResponse: Codable {
    var totalPages: Int?
    var results: [PopularMovieVO] = []
}

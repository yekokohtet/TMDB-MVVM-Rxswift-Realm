//
//  Movie.swift
//  TMDB
//
//  Created by Ye Ko on 01/07/2021.
//

import Foundation
import RealmSwift

class UpcomingMovieVO: Object, Codable {
    @objc dynamic var adult = false
    @objc dynamic var backdropPath: String?
    var genreIds = List<Int>()
    @objc dynamic var id = 0
    @objc dynamic var originalLanguage: String?
    @objc dynamic var originalTitle: String?
    @objc dynamic var overview: String?
    @objc dynamic var popularity: Float = 0.0
    @objc dynamic var posterPath: String?
    @objc dynamic var releaseDate: String?
    @objc dynamic var title: String?
    @objc dynamic var video = false
    @objc dynamic var voteAverage: Float = 0.0
}

class PopularMovieVO: Object, Codable {
    @objc dynamic var adult = false
    @objc dynamic var backdropPath: String?
    var genreIds = List<Int>()
    @objc dynamic var id = 0
    @objc dynamic var originalLanguage: String?
    @objc dynamic var originalTitle: String?
    @objc dynamic var overview: String?
    @objc dynamic var popularity: Float = 0.0
    @objc dynamic var posterPath: String?
    @objc dynamic var releaseDate: String?
    @objc dynamic var title: String?
    @objc dynamic var video = false
    @objc dynamic var voteAverage: Float = 0.0
}

class UpcomingFavouriteStateVO: Object {
    @objc dynamic var movieId: Int = 0
    @objc dynamic var state: Bool = false
}

class PopularFavouriteStateVO: Object {
    @objc dynamic var movieId: Int = 0
    @objc dynamic var state: Bool = false
}

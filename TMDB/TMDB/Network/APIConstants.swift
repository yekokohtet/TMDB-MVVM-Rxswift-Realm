//
//  APIConstants.swift
//  TMDB
//
//  Created by Ye Ko on 01/07/2021.
//

import Foundation

class APIConstants {
    
    static let baseUrl = "https://api.themoviedb.org/3/"
    
    static let posterPath = "https://image.tmdb.org/t/p/original"
    
    enum PARAM_KEY {
        static let PAGE = "page"
        static let API_KEY = "api_key"
        static let LANGUAGE = "language"
    }
    
    enum PARAM_VALUE {
        static let API_KEY_VALUE = "7d56df239f3717c4641ffd5917635441"
        static let LANGUAGE_VALUE = "en-US"
    }
    
    enum ROUTE {
        static let GET_POPULAR_MOVIE_LIST = "movie/popular"
        static let GET_UPCOMING_LIST = "movie/upcoming"
    }
    
}


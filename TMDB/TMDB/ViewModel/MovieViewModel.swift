//
//  MovieViewModel.swift
//  TMDB
//
//  Created by Ye Ko on 02/07/2021.
//

import Foundation

class MovieViewModel: BaseViewModel {
    
    var id: Int
    var title: String
    var posterPath: String
    var voteAverage: String
    var overview: String
    var type: Int
    
    init(title: String?, posterPath: String?, voteAverage: Float, overview: String?, id: Int, type: Int) {
        self.title = title ?? ""
        self.posterPath = posterPath ?? ""
        self.voteAverage = "\(voteAverage)"
        self.overview = overview ?? ""
        self.id = id
        self.type = type
    }
    
    var url: URL? {
        return (URL(string: APIConstants.posterPath + posterPath))
    }
    
}

//
//  RealmHelper.swift
//  TMDB
//
//  Created by Ye Ko on 01/07/2021.
//

import Foundation
import RealmSwift
import RxSwift
import RxRealm
import Realm

class RealmHelper {
    
    private init() {}
    
    static let shared = RealmHelper()
    
    let realm = try! Realm(configuration: Realm.Configuration(schemaVersion: 1))
    
    // MARK: - Upcoming
    
    // insert
    func insertUpcomingMovies(movies: [UpcomingMovieVO]) {
        try! realm.write {
            realm.add(movies)
        }
    }
        
    // read all
    func retrieveUpcomingMovies() -> Observable<[UpcomingMovieVO]> {
        return Observable.array(from: realm.objects(UpcomingMovieVO.self))
    }
        
    // MARK: - Popular
    
    // insert
    func insertPopularMovies(movies: [PopularMovieVO]) {
        try! realm.write {
            realm.add(movies)
        }
    }
        
    // read all
    func retrievePopularMovies() -> Observable<[PopularMovieVO]> {
        return Observable.array(from: realm.objects(PopularMovieVO.self))
    }
    
   
    //MARK: - Favourite State

    // insert
    func insertUpcomingFavouriteState(favouriteState: UpcomingFavouriteStateVO) {
        try! realm.write {
            realm.add(favouriteState)
        }
    }

    // read all
    func retrieveUpcomingFavouriteState() -> Observable<[UpcomingFavouriteStateVO]> {
        return Observable.array(from: realm.objects(UpcomingFavouriteStateVO.self))
    }

    // update
    func updateUpcomingFavouriteStae(movieId: Int, state: Bool) {
        guard let favourite = realm.objects(UpcomingFavouriteStateVO.self).filter("movieId == %@", movieId).first else { return }
        try! realm.write {
            favourite.state = state
        }
    }
    
    
    // insert
    func insertPopularFavouriteState(favouriteState: PopularFavouriteStateVO) {
        try! realm.write {
            realm.add(favouriteState)
        }
    }

    // read all
    func retrievePopularFavouriteState() -> Observable<[PopularFavouriteStateVO]> {
        return Observable.array(from: realm.objects(PopularFavouriteStateVO.self))
    }

    // update
    func updatePopularFavouriteStae(movieId: Int, state: Bool) {
        guard let favourite = realm.objects(PopularFavouriteStateVO.self).filter("movieId == %@", movieId).first else { return }
        try! realm.write {
            favourite.state = state
        }
    }
    
    
}



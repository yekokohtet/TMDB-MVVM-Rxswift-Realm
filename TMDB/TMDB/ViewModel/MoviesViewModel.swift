//
//  MoviesViewModel.swift
//  TMDB
//
//  Created by Ye Ko on 02/07/2021.
//

import Foundation
import RxSwift
import RxCocoa
import RxRealm

protocol MoviesViewModelProtocol {
    func getUpcomingMovies()
    func getPopularMovies()
    func updateUpcomingFavouriteState(id: Int, state: Bool)
    func updatePopularFavouriteState(id: Int, state: Bool)
}

class MoviesViewModel: BaseViewModel {
    
    let db = RealmHelper.shared
        
    var upcomingMoviesObserver: BehaviorRelay<[MovieViewModel]> = BehaviorRelay(value: [])
    var popularMoviesObserver: BehaviorRelay<[MovieViewModel]> = BehaviorRelay(value: [])
    var upcomingFavouriteStateObserver: BehaviorRelay<[UpcomingFavouriteStateVO]> = BehaviorRelay(value: [])
    var popularFavouriteStateObserver: BehaviorRelay<[PopularFavouriteStateVO]> = BehaviorRelay(value: [])
}

extension MoviesViewModel: MoviesViewModelProtocol {
    
    public func getUpcomingMovies() {
        isLoadingObserver.accept(true)
        db.retrieveUpcomingMovies().subscribe(onNext: { [weak self] movies in
            guard let self = self else { return }
            if movies.count > 0 {
                self.isLoadingObserver.accept(false)
                self.upcomingMoviesObserver.accept(movies.map {
                    MovieViewModel(title: $0.title, posterPath: $0.posterPath, voteAverage: $0.voteAverage, overview: $0.overview, id: $0.id, type: 0)
                })
            } else {
                SharedAPIService.shared.apiGetUpcomingMovieList()
                    .subscribeOn(ConcurrentDispatchQueueScheduler.init(queue: DispatchQueue.global()))
                    .subscribe(onNext: { (response) in
                        self.isLoadingObserver.accept(false)
                        self.upcomingMoviesObserver.accept(response.results.map {
                            MovieViewModel(title: $0.title, posterPath: $0.posterPath, voteAverage: $0.voteAverage, overview: $0.overview, id: $0.id, type: 0)
                        })
                        self.db.insertUpcomingMovies(movies: response.results)
                        response.results.forEach { movie in
                            let favouriteStateVO = UpcomingFavouriteStateVO()
                            favouriteStateVO.movieId = movie.id
                            favouriteStateVO.state = false
                            self.db.insertUpcomingFavouriteState(favouriteState: favouriteStateVO)
                        }
                    }, onError: { (err) in
                        self.isLoadingObserver.accept(false)
                        self._errObserver.accept(err.localizedDescription)
                        print(err.localizedDescription)
                    }).disposed(by: self.bag)
            }
        }).disposed(by: bag)
    }
    
    public func getPopularMovies() {
        isLoadingObserver.accept(true)
        db.retrievePopularMovies().subscribe(onNext: { [weak self] movies in
            guard let self = self else { return }
            if movies.count > 0 {
                self.isLoadingObserver.accept(false)
                self.popularMoviesObserver.accept(movies.map {
                    MovieViewModel(title: $0.title, posterPath: $0.posterPath, voteAverage: $0.voteAverage, overview: $0.overview, id: $0.id, type: 1)
                })
            } else {
                SharedAPIService.shared.apiGetPopularMovieList()
                    .subscribeOn(ConcurrentDispatchQueueScheduler.init(queue: DispatchQueue.global()))
                    .subscribe(onNext: { (response) in
                        self.isLoadingObserver.accept(false)
                        self.popularMoviesObserver.accept(movies.map {
                            MovieViewModel(title: $0.title, posterPath: $0.posterPath, voteAverage: $0.voteAverage, overview: $0.overview, id: $0.id, type: 1)
                        })
                        self.db.insertPopularMovies(movies: response.results)
                        response.results.forEach { movie in
                            let favouriteStateVO = PopularFavouriteStateVO()
                            favouriteStateVO.movieId = movie.id
                            favouriteStateVO.state = false
                            self.db.insertPopularFavouriteState(favouriteState: favouriteStateVO)
                        }
                    }, onError: { (err) in
                        self.isLoadingObserver.accept(false)
                        self._errObserver.accept(err.localizedDescription)
                        print(err.localizedDescription)
                    }).disposed(by: self.bag)
            }
        }).disposed(by: bag)
    }
    
    func updateUpcomingFavouriteState(id: Int, state: Bool) {
        db.updateUpcomingFavouriteStae(movieId: id, state: state)
//        getUpcomingFavourites()
    }
    
    func updatePopularFavouriteState(id: Int, state: Bool) {
        db.updatePopularFavouriteStae(movieId: id, state: state)
//        getPopularFavourites()
    }
    
    public func getUpcomingFavourites() {
        db.retrieveUpcomingFavouriteState().subscribe(onNext: { [weak self] favourites in
            guard let self = self else { return }
            self.upcomingFavouriteStateObserver.accept(favourites)
        }).disposed(by: bag)
    }
    
    public func getPopularFavourites() {
        db.retrievePopularFavouriteState().subscribe(onNext: { [weak self] favourites in
            guard let self = self else { return }
            self.popularFavouriteStateObserver.accept(favourites)
        }).disposed(by: bag)
    }
    
}


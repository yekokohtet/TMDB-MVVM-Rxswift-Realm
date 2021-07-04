//
//  ViewController.swift
//  TMDB
//
//  Created by Ye Ko on 01/07/2021.
//

import UIKit
import RxSwift
import RealmSwift

class ViewController: BaseViewController {
    
    @IBOutlet weak var movieListTableView: UITableView!
    @IBOutlet weak var scMovieTab: UISegmentedControl!
    @IBOutlet weak var imgProfile: UIImageView!
    
    let moviesViewModel = MoviesViewModel()
    
    private var upcomingMovieList: [MovieViewModel] = []
    private var popularMovieList: [MovieViewModel] = []
    
    private var upcomingFavouriteList: [UpcomingFavouriteStateVO] = []
    private var popularFavouriteList: [PopularFavouriteStateVO] = []
    
    private var selectedTab = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUIComponent()
        setUpTableView()
        
        moviesViewModel.getUpcomingMovies()
        fetchUpcomingMovie()
        moviesViewModel.getUpcomingFavourites()
        fetchUpcomingFavouriteState()
        
        fetchPopularFavouriteState()
    }
    
    fileprivate func setUpUIComponent() {
        let selected = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let normal = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        scMovieTab.setTitleTextAttributes(normal, for: .normal)
        scMovieTab.setTitleTextAttributes(selected, for: .selected)
        
        imgProfile.layer.cornerRadius = imgProfile.frame.width / 2
    }
    
    fileprivate func setUpTableView() {
        movieListTableView.register(UINib(nibName: MovieListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MovieListTableViewCell.identifier)
        movieListTableView.separatorStyle = .none
        movieListTableView.dataSource = self
        movieListTableView.delegate = self
    }
    
    fileprivate func fetchUpcomingMovie() {
        moviesViewModel.upcomingMoviesObserver.observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] movies in
                guard let self = self else { return }
                self.bindUpcomingData(movies: movies)
            }).disposed(by: bag)
    }
    
    fileprivate func fetchPopularMovie() {
        moviesViewModel.popularMoviesObserver.observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] movies in
                guard let self = self else { return }
                self.bindPopularData(movies: movies)
            }).disposed(by: bag)
    }
    
    fileprivate func fetchUpcomingFavouriteState() {
        moviesViewModel.upcomingFavouriteStateObserver.observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] favourites in
                guard let self = self else { return }
                self.bindUpcomingFavouriteState(favourites: favourites)
            }).disposed(by: bag)
    }
    
    fileprivate func fetchPopularFavouriteState() {
        moviesViewModel.popularFavouriteStateObserver.observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] favourites in
                guard let self = self else { return }
                self.bindPopularFavouriteState(favourites: favourites)
            }).disposed(by: bag)
    }
    
    fileprivate func bindUpcomingData(movies: [MovieViewModel]) {
        upcomingMovieList = movies
        movieListTableView.reloadData()
    }
    
    fileprivate func bindPopularData(movies: [MovieViewModel]) {
        popularMovieList = movies
        movieListTableView.reloadData()
    }
    
    fileprivate func bindUpcomingFavouriteState(favourites: [UpcomingFavouriteStateVO]) {
        upcomingFavouriteList = favourites
        movieListTableView.reloadData()
    }
    
    fileprivate func bindPopularFavouriteState(favourites: [PopularFavouriteStateVO]) {
        popularFavouriteList = favourites
        movieListTableView.reloadData()
    }

    @IBAction func scMovieTab(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            selectedTab = 0
            moviesViewModel.getUpcomingMovies()
            fetchUpcomingMovie()
            moviesViewModel.getUpcomingFavourites()
            fetchUpcomingFavouriteState()
        } else {
            selectedTab = 1
            moviesViewModel.getPopularMovies()
            fetchPopularMovie()
            moviesViewModel.getPopularFavourites()
            fetchPopularFavouriteState()
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedTab == 0 {
            return upcomingMovieList.count
        } else {
            return popularMovieList.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.identifier, for: indexPath) as! MovieListTableViewCell
        if selectedTab == 0 {
            cell.movie = upcomingMovieList[indexPath.row]
            cell.upcoming = upcomingFavouriteList[indexPath.row]
        } else {
            cell.movie = popularMovieList[indexPath.row]
            cell.popular = popularFavouriteList[indexPath.row]
        }
        cell.delegate = self
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(identifier: DetailsViewController.identifier) as! DetailsViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        if selectedTab == 0 {
            vc.movie = upcomingMovieList[indexPath.row]
            vc.upcomingFavourite = upcomingFavouriteList[indexPath.row]
        } else {
            vc.movie = popularMovieList[indexPath.row]
            vc.popularFavourite = popularFavouriteList[indexPath.row]
        }
    }
    
}

extension ViewController: MovieListItemDelegate {
    func onTapItemUpcomingFavourite(id: Int, state: Bool) {
        moviesViewModel.updateUpcomingFavouriteState(id: id, state: state)
        moviesViewModel.getUpcomingFavourites()
    }
    
    func onTapItemPopularFavourite(id: Int, state: Bool) {
        moviesViewModel.updatePopularFavouriteState(id: id, state: state)
        moviesViewModel.getPopularFavourites()
    }
}

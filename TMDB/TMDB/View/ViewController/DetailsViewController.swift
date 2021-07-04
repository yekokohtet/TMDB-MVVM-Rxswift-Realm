//
//  DetailsViewController.swift
//  TMDB
//
//  Created by Ye Ko on 02/07/2021.
//

import UIKit
import SDWebImage

class DetailsViewController: BaseViewController {
    
    static let identifier = "DetailsViewController"

    @IBOutlet weak var btnBack: UIView!
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var outterViewVoteAverage: UIView!
    @IBOutlet weak var innerViewVoteAverage: UIView!
    @IBOutlet weak var lblVoteAverage: UILabel!
    @IBOutlet weak var btnFavourite: UIView!
    @IBOutlet weak var ivFavourite: UIImageView!
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    
    let detailsViewModel = DetailsViewModel()
    
    var movie: MovieViewModel? {
        didSet {
            if let movie = movie, let url = movie.url {
                imgPoster.sd_setImage(with: url)
                lblMovieTitle.text = movie.title
                lblOverview.text = movie.overview
                lblVoteAverage.text = movie.voteAverage
            }
        }
    }
    
    var upcomingFavourite: UpcomingFavouriteStateVO? {
        didSet {
            if let favourite = upcomingFavourite {
                refreshFavouriteTintColor(state: favourite.state)
            }
        }
    }
    
    var popularFavourite: PopularFavouriteStateVO? {
        didSet {
            if let favourite = popularFavourite {
                refreshFavouriteTintColor(state: favourite.state)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUIComponent()
    }
    
    @objc func onTapBack() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func onTapFavourite() {
        if let upcoming = upcomingFavourite {
            refreshFavouriteTintColor(state: !upcoming.state)
            detailsViewModel.updateUpcomingFavouriteState(id: upcoming.movieId, state: !upcoming.state)
        } else {
            if let popular = popularFavourite {
                refreshFavouriteTintColor(state: !popular.state)
                detailsViewModel.updatePopularFavouriteState(id: popular.movieId, state: !popular.state)
            }
        }
    }
    
    fileprivate func refreshFavouriteTintColor(state: Bool) {
        ivFavourite.tintColor = state ? UIColor.red : UIColor.systemBackground
    }
    
    fileprivate func setUpUIComponent() {
        btnBack.layer.cornerRadius = btnBack.frame.width / 2
        
        btnBack.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapBack))
        btnBack.addGestureRecognizer(tapGesture)
        
        btnFavourite.isUserInteractionEnabled = true
        let tapFavouriteGesture = UITapGestureRecognizer(target: self, action: #selector(onTapFavourite))
        btnFavourite.addGestureRecognizer(tapFavouriteGesture)
        
        // Vote Average
        outterViewVoteAverage.layer.borderColor = UIColor.white.cgColor
        outterViewVoteAverage.layer.borderWidth = 1
        
        outterViewVoteAverage.layer.cornerRadius = outterViewVoteAverage.frame.width / 2
        innerViewVoteAverage.layer.cornerRadius = innerViewVoteAverage.frame.width / 2
        
        //Favourite
        ivFavourite.image = UIImage(systemName: "heart.fill")
    }
}

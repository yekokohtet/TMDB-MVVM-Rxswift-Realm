//
//  MovieListTableViewCell.swift
//  TMDB
//
//  Created by Ye Ko on 02/07/2021.
//

import UIKit
import SDWebImage

protocol MovieListItemDelegate {
    func onTapItemUpcomingFavourite(id: Int, state: Bool)
    func onTapItemPopularFavourite(id: Int, state: Bool)
}

class MovieListTableViewCell: UITableViewCell {
    
    static let identifier = "MovieListTableViewCell"

    @IBOutlet weak var transparentLayer: UIView!
    @IBOutlet weak var outerViewVoteAverage: UIView!
    @IBOutlet weak var innerViewVoteAverage: UIView!
    @IBOutlet weak var lblVoteAverage: UILabel!
    @IBOutlet weak var btnFavourite: UIView!
    @IBOutlet weak var ivFavourite: UIImageView!
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var imgMoviePoster: UIImageView!
    
    var movie: MovieViewModel? {
        didSet {
            if let movie = movie, let url = movie.url {
                bind(title: movie.title, posterPath: url, voteAverage: movie.voteAverage)
            }
        }
    }
    
    var upcoming: UpcomingFavouriteStateVO? {
        didSet {
            if let upcoming = upcoming {
                ivFavourite.tintColor = upcoming.state ? UIColor.red : UIColor.systemBackground
            }
        }
    }
    
    var popular: PopularFavouriteStateVO? {
        didSet {
            if let popular = popular {
                ivFavourite.tintColor = popular.state ? UIColor.red : UIColor.systemBackground
            }
        }
    }
    
    var delegate: MovieListItemDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        
        ivFavourite.tintColor = .systemBackground
        
        ivFavourite.image = UIImage(systemName: "heart.fill")
        imgMoviePoster.layer.cornerRadius = 30
        
        //Transparent Layer
        transparentLayer.layer.cornerRadius = 30
        
        outerViewVoteAverage.layer.cornerRadius = outerViewVoteAverage.frame.width / 2
        innerViewVoteAverage.layer.cornerRadius = innerViewVoteAverage.frame.width / 2
        
        //OuterView Border Colour Change
        outerViewVoteAverage.layer.borderColor = UIColor.white.cgColor
        outerViewVoteAverage.layer.borderWidth = 1
        
        //Button Favourite
        btnFavourite.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapFavourite))
        btnFavourite.addGestureRecognizer(tapGesture)
    }
    
    @objc func onTapFavourite() {
        
        if let type = movie?.type {
            if type == 0 {
                if let upcoming = upcoming {
                    delegate?.onTapItemUpcomingFavourite(id: upcoming.movieId, state: !upcoming.state)
                    ivFavourite.tintColor = upcoming.state ? UIColor.red : UIColor.systemBackground
                }
            } else {
                if let popular = popular {
                    delegate?.onTapItemPopularFavourite(id: popular.movieId, state: !popular.state)
                    ivFavourite.tintColor = popular.state ? UIColor.red : UIColor.systemBackground
                }
            }
        }
        
        
    }

    fileprivate func bind(title: String, posterPath: URL, voteAverage: String) {
        lblMovieTitle.text = title
        imgMoviePoster.sd_setImage(with: posterPath)
        lblVoteAverage.text = voteAverage
    }
    
}

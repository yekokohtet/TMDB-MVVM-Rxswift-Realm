//
//  DetailsViewModel.swift
//  TMDB
//
//  Created by Ye Ko on 02/07/2021.
//

import Foundation
import RxCocoa

protocol DetailsViewModelProtocol {
    func updateUpcomingFavouriteState(id: Int, state: Bool)
    func updatePopularFavouriteState(id: Int, state: Bool)
}

class DetailsViewModel: BaseViewModel {
    
    let db = RealmHelper.shared
        
}

extension DetailsViewModel: DetailsViewModelProtocol {
    
    func updateUpcomingFavouriteState(id: Int, state: Bool) {
        db.updateUpcomingFavouriteStae(movieId: id, state: state)
    }
    
    func updatePopularFavouriteState(id: Int, state: Bool) {
        db.updatePopularFavouriteStae(movieId: id, state: state)
    }
}

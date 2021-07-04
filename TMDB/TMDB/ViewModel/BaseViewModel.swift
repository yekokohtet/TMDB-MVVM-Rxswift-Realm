//
//  BaseViewModel.swift
//  TMDB
//
//  Created by Ye Ko on 02/07/2021.
//

import Foundation
import RxSwift
import RxCocoa

class BaseViewModel {
    
    let bag = DisposeBag()
    
    var isLoadingObserver: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    var _errObserver: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    
}

//
//  BaseViewController.swift
//  TMDB
//
//  Created by Ye Ko on 02/07/2021.
//

import UIKit
import RxSwift
import NVActivityIndicatorView

class BaseViewController: UIViewController {
    
    let baseViewModel = BaseViewModel()
    let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        baseViewModel.isLoadingObserver
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (state) in
                if state {
                    self.showProgress()
                } else {
                    self.hideProgress()
                }
            }).disposed(by: bag)
        
        baseViewModel._errObserver
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (err) in
                guard let err = err else { return }
                self.showRegisterDialog(title: "Error", message: err)
            }).disposed(by: bag)
    }
    
    
    func showRegisterDialog(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        let okAction = UIAlertAction(title: "Try again", style: .default) { _ in
            
        }
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    

}

extension BaseViewController: NVActivityIndicatorViewable {
    
    func showProgress() {
        startAnimating(CGSize(width: 30, height: 30), type: NVActivityIndicatorType.audioEqualizer)
    }
    
    func hideProgress() {
        stopAnimating()
    }
}

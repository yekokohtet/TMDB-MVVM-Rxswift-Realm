//
//  NetworkClient.swift
//  TMDB
//
//  Created by Ye Ko on 01/07/2021.
//

import Foundation
import RxSwift
import Alamofire
import SwiftyJSON

class BaseNetworkClient {
    
    let decoder = JSONDecoder()
    
    public func getData<T>(route : String,
                        headers : HTTPHeaders,
                        parameters : Parameters,
                        value: T.Type) -> Observable<T> where T: Codable {
        
        print("request url ==> \(APIConstants.baseUrl + route)")
        
        return Observable<T>.create({ (observer) -> Disposable in
            
            let request = AF.request(APIConstants.baseUrl + route, method: .get, parameters : parameters, headers : headers).responseJSON { (response) in
                
                switch response.result {
                    
                case .success:
                    
                    if 200 ... 299 ~= response.response?.statusCode ?? 500 {
                        
                        if let responseData = response.data {
                            do {
                                self.decoder.keyDecodingStrategy = .convertFromSnakeCase
                                let data = try self.decoder.decode(T.self, from: responseData)
                                observer.onNext(data)
                                observer.onCompleted()
                            } catch let err {
                                observer.onError(err)
                            }
                        }
                        
                    } else {
                        let error = response.data?.serializeData(for: Error.self)
                        observer.onError(NSError(domain: error?.message ?? "", code: response.response?.statusCode ?? 500, userInfo: nil))
                    }
                   
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create(with: {
                request.cancel()
            })
            
        })
    
    }
    
}

//
//  SupportingServices.swift
//  MovieApplication
//
//  Created by Бекдаулет Касымов on 7/4/19.
//  Copyright © 2019 Бекдаулет Касымов. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct NetworkService {
    static func requestMovies(completion: @escaping (JSON) -> ()) {
        
        let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=7b3633c685b1681577e67baa99cce643&language=en-US"
        guard let url = URL(string: urlString) else {
            return
        }
        
        Alamofire.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completion(json)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

    }
    
    static func requestReviews(movie: Movie, completion: @escaping (JSON) -> ()) {
        let urlString = "https://api.themoviedb.org/3/movie/\(movie.id)/reviews?api_key=7b3633c685b1681577e67baa99cce643&language=en-US"
        guard let url = URL(string: urlString) else {
            return
        }
        
        Alamofire.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completion(json)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func requestTrailers(movie: Movie, completion: @escaping (JSON) -> ()) {
        let urlString = "https://api.themoviedb.org/3/movie/\(movie.id)/videos?api_key=7b3633c685b1681577e67baa99cce643&language=en-US"
        guard let url = URL(string: urlString) else { return }
        
        Alamofire.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completion(json)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

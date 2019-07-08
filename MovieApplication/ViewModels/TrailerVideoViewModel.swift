//
//  TrailerVideoViewModel.swift
//  MovieApplication
//
//  Created by Бекдаулет Касымов on 7/8/19.
//  Copyright © 2019 Бекдаулет Касымов. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol TrailerVideoViewModelDelegate: class {
    func didFetchTrailer()
}

class TrailerVideoViewModel {
    var movie: Movie
    var movieTrailers: [MovieTrailer] = []
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    weak var delegate: TrailerVideoViewModelDelegate?
    
    func getMovieTrailer(json: JSON) {
        for item in json["results"] {
            let movieTrailer = MovieTrailer(id: item.1["id"].stringValue, key: item.1["key"].stringValue, name: item.1["name"].stringValue)
            movieTrailers.append(movieTrailer)
        }
    }
    
    func makeRequset() {
        NetworkService.requestTrailers(movie: self.movie) { [weak self] request in
            for item in request["results"] {
                let movieTrailer = MovieTrailer(id: item.1["id"].stringValue, key: item.1["key"].stringValue, name: item.1["name"].stringValue)
                self?.movieTrailers.append(movieTrailer)
                DispatchQueue.main.async {
                    self?.delegate?.didFetchTrailer()
                }
            }
        }
    }
}

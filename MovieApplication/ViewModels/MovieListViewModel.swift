//
//  MovieListViewModel.swift
//  MovieApplication
//
//  Created by Бекдаулет Касымов on 7/4/19.
//  Copyright © 2019 Бекдаулет Касымов. All rights reserved.
//

import Foundation

protocol MovieListViewModelDelegate: class {
    func didFetchMovies()
}

class MovieListViewModel {
    private var movies: [Movie] = []
    
    weak var delegate: MovieListViewModelDelegate?
    
    func getNumberOfMovies() -> Int {
        return movies.count
    }
    
    func getMovie(at index: Int) -> Movie {
        return movies[index]
    }
    
    func makeRequest() {
        NetworkService.requestMovies(completion: { [weak self] (response) in
            for item in response["results"] {
                self?.movies.append(Movie(json: item.1))
                DispatchQueue.main.async {
                    self?.delegate?.didFetchMovies()
                }
            }
        })
    }
}

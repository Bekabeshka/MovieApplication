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
        self.movies = NetworkService.requestMovies()
        DispatchQueue.main.async {
            self.delegate?.didFetchMovies()
        }
    }
}

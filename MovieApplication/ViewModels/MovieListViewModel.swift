//
//  MovieListViewModel.swift
//  MovieApplication
//
//  Created by Бекдаулет Касымов on 7/4/19.
//  Copyright © 2019 Бекдаулет Касымов. All rights reserved.
//

import Foundation
import UIKit

protocol MovieListViewModelDelegate: class {
    func didFetchMovies()
}

class MovieListViewModel {
    private var page = 1
    private var previousRequest = 0
    private var movies: [Movie] = []
    
    weak var delegate: MovieListViewModelDelegate?
    
    func getNumberOfMovies() -> Int {
        return movies.count
    }
    
    func getMovie(at index: Int) -> Movie {
        return movies[index]
    }
    
    func isReadyForNewRequest(indexPathRow: Int) -> Bool {
        if indexPathRow - 15 > previousRequest {
            previousRequest += 20
            return true
        }
        return false
    }
    
    func makeRequest() {
        NetworkService.requestMovies(page: self.page, completion: { [weak self] (response) in
            for item in response["results"] {
                self?.movies.append(Movie(json: item.1))
                DispatchQueue.main.async {
                    self?.delegate?.didFetchMovies()
                }
            }
            self?.page += 1
        })
    }
}

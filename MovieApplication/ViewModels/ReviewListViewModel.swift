//
//  ReviewListViewModel.swift
//  MovieApplication
//
//  Created by Бекдаулет Касымов on 7/4/19.
//  Copyright © 2019 Бекдаулет Касымов. All rights reserved.
//

import Foundation

protocol ReviewListViewModelDelegate: class {
    func didFetchReviews()
}

class ReviewListViewModel {
    private let movie: Movie
    private var reviews: [Review] = []
    
    weak var delegate: ReviewListViewModelDelegate?
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func getNumberOfReviews() -> Int {
        return reviews.count
    }
    
    func getReview(at index: Int) -> Review {
        return reviews[index]
    }
    
    func makeRequest() {
        NetworkService.requestReviews(movie: movie) { [weak self] requset in
            for item in requset["results"] {
                self?.reviews.append(Review(json: item.1))
                DispatchQueue.main.async {
                    self?.delegate?.didFetchReviews()
                }
            }
        }
    }
}

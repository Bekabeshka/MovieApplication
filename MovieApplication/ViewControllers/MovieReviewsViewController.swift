//
//  MovieReviewsViewController.swift
//  MovieApplication
//
//  Created by Бекдаулет Касымов on 7/4/19.
//  Copyright © 2019 Бекдаулет Касымов. All rights reserved.
//

import UIKit

class MovieReviewsViewController: UIViewController {

    lazy var reviewsTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.register(ReviewTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    let viewModel: ReviewListViewModel
    
    init(movie: Movie) {
        viewModel = ReviewListViewModel(movie: movie)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Reviews"
        view.backgroundColor = .white
        
        viewModel.delegate = self
        viewModel.makeRequest()
        
        setupLayout()
    }
    
    func setupLayout() {
        view.addSubview(reviewsTableView)
        reviewsTableView.snp.makeConstraints({make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        })
    }
}

extension MovieReviewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfReviews()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = reviewsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ReviewTableViewCell else {
            return UITableViewCell()
        }
        cell.setData(review: viewModel.getReview(at: indexPath.row))
        return cell
    }
}

extension MovieReviewsViewController: ReviewListViewModelDelegate {
    func didFetchReviews() {
        reviewsTableView.reloadData()
    }
}

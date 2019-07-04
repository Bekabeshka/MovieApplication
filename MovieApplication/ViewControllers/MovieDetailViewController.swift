//
//  MovieDetailViewController.swift
//  MovieApplication
//
//  Created by Бекдаулет Касымов on 7/4/19.
//  Copyright © 2019 Бекдаулет Касымов. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieDetailViewController: UIViewController {

    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    let averageVoteLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    lazy var reviewButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show reviews", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(didTapReviewButton), for: .touchUpInside)
        return button
    }()
    
    
    
    let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
        //MARK: why?
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Movie detail"
        view.backgroundColor = .white
        
        setupLayout()
    }
    
    func setupLayout() {
        if let posterURL = URL(string: movie.posterFullPath) {
            posterImageView.af_setImage(withURL: posterURL)
        }
        
        view.addSubview(posterImageView)
        posterImageView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(300)
            make.width.equalToSuperview().multipliedBy(0.3)
        }
        
        view.addSubview(titleLabel)
        titleLabel.text = movie.title
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(posterImageView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        view.addSubview(averageVoteLabel)
        averageVoteLabel.text = movie.voteAverage.description
        averageVoteLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        view.addSubview(reviewButton)
        reviewButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(60)
        }
    }
    
    @IBAction func didTapReviewButton() {
        let movieReviewsViewController = MovieReviewsViewController(movie: movie)
        navigationController?.pushViewController(movieReviewsViewController, animated: true)
    }
    
}

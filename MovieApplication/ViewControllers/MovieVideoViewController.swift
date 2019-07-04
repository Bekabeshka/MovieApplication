//
//  MovieVideoViewController.swift
//  MovieApplication
//
//  Created by Бекдаулет Касымов on 7/4/19.
//  Copyright © 2019 Бекдаулет Касымов. All rights reserved.
//

import UIKit

class MovieVideoViewController: UIViewController {

    private let movie: Movie
    let trailerWebView: UIWebView = {
        let webView = UIWebView()
        return webView
    }()

    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        let url = URL(string: "https://www.youtube.com/watch?v=q2PJ0kdrYIs")!
        let request = URLRequest(url: url)
        trailerWebView.loadRequest(request)
    }
    
    func setupLayout() {
        view.addSubview(trailerWebView)
        trailerWebView.snp.makeConstraints({make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(150)
        })
        
        
    }

}

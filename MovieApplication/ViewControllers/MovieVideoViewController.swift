//
//  MovieVideoViewController.swift
//  MovieApplication
//
//  Created by Бекдаулет Касымов on 7/4/19.
//  Copyright © 2019 Бекдаулет Касымов. All rights reserved.
//

import UIKit
import SnapKit
import SVProgressHUD

class MovieVideoViewController: UIViewController {
    
    private let viewModel: TrailerVideoViewModel
    lazy var trailerWebView = UIWebView()

    init(movie: Movie) {
        self.viewModel = TrailerVideoViewModel(movie: movie)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        viewModel.delegate = self
        viewModel.makeRequset()
        
        setupLayout()
    }
    
    func setupLayout() {
        view.addSubview(trailerWebView)
        trailerWebView.delegate = self
        trailerWebView.snp.makeConstraints({make in
            make.top.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        })
    }
}

extension MovieVideoViewController: TrailerVideoViewModelDelegate {
    func didFetchTrailer() {
        guard let movieTrailer = viewModel.movieTrailers.first else { return }
        guard let url = URL(string: "https://www.youtube.com/embed/\(movieTrailer.key)") else { return }
        let request = URLRequest(url: url)
        trailerWebView.contentMode = .scaleAspectFill
        trailerWebView.loadRequest(request)
        
        SVProgressHUDStyle.light
        SVProgressHUD.show(withStatus: "Loading")
    }
}

extension MovieVideoViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        if webView.isLoading {
            return
        }
        
        SVProgressHUD.dismiss()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print(error.localizedDescription)
    }
}

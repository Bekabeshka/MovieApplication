//
//  ViewController.swift
//  MovieApplication
//
//  Created by Бекдаулет Касымов on 7/2/19.
//  Copyright © 2019 Бекдаулет Касымов. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class ViewController: UIViewController {

    let viewModel = MovieListViewModel()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.prefetchDataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "Popular movies"
        view.backgroundColor = .white
        
        viewModel.delegate = self
        viewModel.makeRequest()
        
        setupLayout()
    }
    
    func setupLayout() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints({make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(5)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-5)
        })
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            let movie = viewModel.getMovie(at: indexPath.row)
            guard let imageUrl = URL(string: movie.posterFullPath) else {
                return
            }
            if let data = try? Data(contentsOf: imageUrl) {
                if let image = UIImage(data: data) {
                    Cache.imageCache.setObject(image, forKey: NSString(string: movie.title))
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getNumberOfMovies()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if viewModel.isReadyForNewRequest(indexPathRow: indexPath.row) {
            viewModel.makeRequest()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        let movie = viewModel.getMovie(at: indexPath.row)
        guard let imageUrl = URL(string: movie.posterFullPath) else {
            return cell
        }
        cell.setImage(url: imageUrl, key: NSString(string: movie.title))
//        cell.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 2 - 2, height: collectionView.bounds.height * 0.4 - 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieDetailViewController = MovieDetailViewController(movie: viewModel.getMovie(at: indexPath.row))
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
}

extension ViewController: MovieListViewModelDelegate {
    func didFetchMovies() {
        collectionView.reloadData()
    }
}

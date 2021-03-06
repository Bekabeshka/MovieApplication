//
//  MovieCollectionViewCell.swift
//  MovieApplication
//
//  Created by Бекдаулет Касымов on 7/4/19.
//  Copyright © 2019 Бекдаулет Касымов. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        imageView.snp.makeConstraints({make in
            make.top.bottom.leading.trailing.equalToSuperview()
        })
    }
    
    func setImage(url: URL, key: NSString) {
        imageView.image = nil
        if let image = Cache.imageCache.object(forKey: key) {
            imageView.image = image
        } else {
            imageView.af_setImage(withURL: url)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

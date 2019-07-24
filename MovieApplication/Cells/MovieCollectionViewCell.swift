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
    
    func setImage(from url: URL, andKey key: NSString) {
        if let image = Cache.imageCache.object(forKey: key) {
            imageView.image = image
        } else {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    Cache.imageCache.setObject(image, forKey: key)
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

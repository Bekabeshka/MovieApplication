//
//  SupportingStructures.swift
//  MovieApplication
//
//  Created by Бекдаулет Касымов on 7/4/19.
//  Copyright © 2019 Бекдаулет Касымов. All rights reserved.
//

import Foundation
import SwiftyJSON

class Movie: Decodable {
    let id: Int
    let title: String
    let posterPath: String
    let overview: String
    let voteAverage: Float
    let releaseDate: String
    
    var posterFullPath: String {
        return "https://image.tmdb.org/t/p/original" + posterPath
    }
    
    init(json: JSON) {
        id = json["id"].intValue
        title = json["title"].stringValue
        posterPath = json["poster_path"].stringValue
        overview = json["overview"].stringValue
        voteAverage = json["vote_average"].floatValue
        releaseDate = json["release_date"].stringValue
    }
    
    init(id: Int, title: String, posterPath: String, overview: String, voteAverage: Float, releaseDate: String) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.overview = overview
        self.voteAverage = voteAverage
        self.releaseDate = releaseDate
    }
}

struct Review {
    let id: String
    let author: String
    let content: String
}

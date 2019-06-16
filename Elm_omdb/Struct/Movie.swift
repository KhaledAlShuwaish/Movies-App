//
//  Movie.swift
//  Elm_omdb
//
//  Created by Khaled Shuwaish on 24/03/2019.
//  Copyright © 2019 Khaled Shuwaish. All rights reserved.
//

import Foundation

struct  MovieResult: Codable {
    var Search: [Movie]
}
struct Movie: Codable {
    var Title : String
    var Year : String
    var imdbID : String
    var `Type` : String
    var Poster : String
}

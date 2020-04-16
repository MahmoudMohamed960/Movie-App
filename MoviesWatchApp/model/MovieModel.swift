//
//  MovieModel.swift
//  MoviesWatchApp
//
//  Created by Mostafa Samir on 1/3/20.
//  Copyright © 2020 MahmoudMohamed. All rights reserved.
//

import UIKit

class MovieModel {
    var id:Int?
    var title :String?
    var poster:String?
    var overView:String?
    var rating:NSNumber?
    var releaseDate:String?
    var popularity : NSNumber?
    init() {
    }
    init(id :Int,title:String,poster:String,overView:String, rating:NSNumber,releaseDate:String,popularity : NSNumber) {
        self.id=id
        self.title=title
        self.poster=poster
        self.overView=overView
        self.rating=rating
        self.releaseDate=releaseDate
        self.popularity = popularity
    }
}

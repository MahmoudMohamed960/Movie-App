//
//  ReviewsModel.swift
//  MoviesWatchApp
//
//  Created by Mostafa Samir on 1/7/20.
//  Copyright © 2020 MahmoudMohamed. All rights reserved.
//

import UIKit

class ReviewsModel {
    var author :String?
    var content:String?
    init() {
    }
    init(author:String,content:String?) {
        self.author = author
        self.content = content
    }
}

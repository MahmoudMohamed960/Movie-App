//
//  VideosModel.swift
//  MoviesWatchApp
//
//  Created by Mostafa Samir on 1/7/20.
//  Copyright © 2020 MahmoudMohamed. All rights reserved.
//

import UIKit

class VideosModel {
    var key :String?
    var name:String?
    init() {
    }
    init(key:String,name:String?) {
        self.key = key
        self.name = name
    }
}

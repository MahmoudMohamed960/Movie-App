//
//  NetWorkModel.swift
//  MoviesWatchApp
//
//  Created by Mostafa Samir on 1/3/20.
//  Copyright © 2020 MahmoudMohamed. All rights reserved.
//

import UIKit
import AFNetworking
class NetWorkModel {
 static var netWorkModel = NetWorkModel()
 var moviesList:[MovieModel] = []
 var movieReviewsList:[ReviewsModel] = []
 var movieVideosList :[VideosModel] = []
 let manager = AFHTTPSessionManager()
 let imageUrl = "http://image.tmdb.org/t/p/w185"
 let coreModel = CoreModel.coreModel
 private init ()
 {

 }
    func getMovieDetails(urlBase : String) {
    moviesList = []
    manager.get(
        urlBase,
        parameters: nil,
        success:
        {
            (operation, responseObject) in
            
            self.coreModel.deleteAllData()
            if let jsonObject = responseObject as?  [String : Any]
            {
                let movies = jsonObject["results"] as! [[String : Any]]
                for item in movies
               {
                let id = item["id"] as! Int
                let poster = self.imageUrl + (item["poster_path"] as! String)
                let title = item["original_title"] as! String
                let overView = item["overview"] as! String
                let rate = item["vote_average"] as! NSNumber
                let releaseDate = item["release_date"] as! String
                let popularity = item["popularity"] as! NSNumber
                let movie = MovieModel(id: id, title: title, poster: poster, overView: overView, rating: rate, releaseDate: releaseDate,popularity:popularity)
                self.moviesList.append(movie)
                self.coreModel.save(model: movie)
            }
                print("count net : \(self.moviesList.count)")
            }
          DispatchQueue.main.async {
           NotificationCenter.default.post(name: NSNotification.Name("load"), object: nil)
          }
    },
        failure:
        {
            (operation, error) in
            print("Error: " + error.localizedDescription)
    })
    }
    func getMovieReviews(urlBase : String) {
        movieReviewsList = []
        manager.get(
            urlBase,
            parameters: nil,
            success:
            {
                (operation, responseObject) in
                if let jsonObject = responseObject as?  [String : Any]
                {
                    let movies = jsonObject["results"] as! [[String : Any]]
                    for item in movies
                    {
                        let author = item["author"]
                        let content = item["content"]
                        let review = ReviewsModel(author: author as! String, content: content as! String)
                        self.movieReviewsList.append(review)
                    }
                    print("count net : \(self.movieReviewsList.count)")
                }
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: NSNotification.Name("load reviews"), object: self.movieReviewsList)
                }
        },
    failure:
    {
    (operation, error) in
    print("Error: " + error.localizedDescription)
    })
    }
    
    func getMovieVideo(urlBase : String) {
        movieVideosList = []
        manager.get(
            urlBase,
            parameters: nil,
            success:
            {
                (operation, responseObject) in
                if let jsonObject = responseObject as?  [String : Any]
                {
                    let movies = jsonObject["results"] as! [[String : Any]]
                    for item in movies
                    {
                        let key = item["key"]
                        let name = item["name"]
                        let vedio = VideosModel(key: key as! String, name: name as! String)
                        self.movieVideosList.append(vedio)
                    }
                    print("count net : \(self.movieVideosList.count)")
                }
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: NSNotification.Name("load videos"), object: self.movieVideosList)
                }
        },
            failure:
            {
                (operation, error) in
                print("Error: " + error.localizedDescription)
        })
    }
    
}

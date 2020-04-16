//
//  CoreModel .swift
//  MovieAppNetwork
//
//  Created by Mostafa Samir on 12/29/19.
//  Copyright © 2020 AhmedSaber. All rights reserved.
//

import Foundation
import CoreData
import UIKit
class CoreModel {
    static let coreModel = CoreModel()
    private init ()
    {
        
    }
    func save (model : MovieModel)
    {
        var appDelegate = UIApplication.shared.delegate as! AppDelegate
        var contextManger = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Movies", in: contextManger)
        let movie = NSManagedObject(entity: entity!, insertInto: contextManger)
        movie.setValue(model.id, forKey: "id")
        movie.setValue(model.title, forKey: "title")
        movie.setValue(model.poster, forKey: "poster")
        movie.setValue(model.rating, forKey: "rate")
        movie.setValue(model.releaseDate, forKey: "releaseDate")
        movie.setValue(model.overView, forKey: "overView")
        movie.setValue(model.popularity, forKey: "popularity")
        do {
            try contextManger.save()
        } catch let error as NSError {
            print(error)
        }
        
    }
    func fetchData () -> [MovieModel]
    {
        var movies = [MovieModel]()
        var fetchMovies = [NSManagedObject]()
        var appDelegate = UIApplication.shared.delegate as! AppDelegate
        var contextManger = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Movies")
        do {
            fetchMovies = try contextManger.fetch(fetchRequest)
            for item in fetchMovies {
                let id = item.value(forKey: "id")
                let title = item.value(forKey: "title")
                let overView = item.value(forKey: "overView")
                let rate = item.value(forKey: "rate")
                let releaseDate = item.value(forKey: "releaseDate")
                let poster = item.value(forKey: "poster")
                let popularity = item.value(forKey: "popularity")
                let movie = MovieModel(id: id as! Int, title: title as! String, poster: poster as! String, overView: overView as! String, rating: rate as! NSNumber, releaseDate: releaseDate as! String,popularity:popularity as! NSNumber )
                movies.append(movie)
            }
        } catch let error as NSError {
            print(error)
        }
        print("movies count = \(movies.count)")
        return movies
    }
    func deleteAllData() {
        var fetchMovies = [NSManagedObject]()
        var appDelegate = UIApplication.shared.delegate as! AppDelegate
        var contextManger = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Movies")
        do {
            fetchMovies = try contextManger.fetch(fetchRequest)
            for object in fetchMovies {
                guard let objectData = object as? NSManagedObject else {continue}
                
                contextManger.delete(objectData)
            }
        } catch let error {
            print("Detele all data  error :", error)
        }
    }
    func saveFavourite (model : MovieModel)
    {
        var appDelegate = UIApplication.shared.delegate as! AppDelegate
        var contextManger = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Favourites", in: contextManger)
        let favourit = NSManagedObject(entity: entity!, insertInto: contextManger)
        favourit.setValue(model.id, forKey: "id")
        favourit.setValue(model.title, forKey: "title")
        favourit.setValue(model.poster, forKey: "poster")
        favourit.setValue(model.rating, forKey: "rate")
        favourit.setValue(model.releaseDate, forKey: "releaseDate")
        favourit.setValue(model.overView, forKey: "overView")
        favourit.setValue(model.popularity, forKey: "popularity")
        
        do {
            try contextManger.save()
        } catch let error as NSError {
            print(error)
        }
        
    }
    func fetchFavourite () -> [MovieModel]
    {
        var fetchFavourits = [NSManagedObject]()
        var  favourits: [MovieModel] = []
        var appDelegate = UIApplication.shared.delegate as! AppDelegate
        var contextManger = appDelegate.persistentContainer.viewContext
        let fetchRequestFavourite = NSFetchRequest<NSManagedObject>(entityName: "Favourites")
        
        do {
            fetchFavourits = try contextManger.fetch(fetchRequestFavourite)
            for item in fetchFavourits {
                let id = item.value(forKey: "id")
                let title = item.value(forKey: "title")
                let overView = item.value(forKey: "overView")
                let rate = item.value(forKey: "rate")
                let releaseDate = item.value(forKey: "releaseDate")
                let poster = item.value(forKey: "poster")
                let popularity = item.value(forKey: "popularity")
                let movie = MovieModel(id: id as! Int, title: title as! String, poster: poster as! String, overView: overView as! String, rating: rate as! NSNumber, releaseDate: releaseDate as! String,popularity:popularity as! NSNumber )
                favourits.append(movie)
            }
        } catch let error as NSError {
            print(error)
        }
        return favourits
        
    }
    func deleteItemFavourites(model:MovieModel) {
        var fetchMovies = [NSManagedObject]()
        var appDelegate = UIApplication.shared.delegate as! AppDelegate
        var contextManger = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favourites")
        do {
            fetchMovies = try contextManger.fetch(fetchRequest)
            for object in fetchMovies {
                let id = object.value(forKey: "id") as! Int
                if id == model.id
                {
                    guard let objectData = object as? NSManagedObject else {continue}
                    contextManger.delete(objectData)
                }
            }
        } catch let error {
            print("Detele all data  error :", error)
        }
    }
    
}

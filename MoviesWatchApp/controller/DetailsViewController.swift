//
//  DetailsViewController.swift
//  MoviesWatchApp
//
//  Created by Mostafa Samir on 1/6/20.
//  Copyright © 2020 MahmoudMohamed. All rights reserved.
//

import UIKit
import SDWebImage
import Cosmos
class DetailsViewController: UIViewController , UITableViewDataSource, UITableViewDelegate , UICollectionViewDelegate,UICollectionViewDataSource {
   
    
   
    
    
    @IBOutlet weak var favouriteBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDate: UILabel!
  
    @IBOutlet weak var movieRate: CosmosView!
    
    @IBOutlet weak var movieDetails: UITableView!
    @IBOutlet weak var movieDescription: UITextView!
    var model : MovieModel = MovieModel()
    var netWorkModel = NetWorkModel.netWorkModel
    var movieReviewsList:[ReviewsModel] = []
    var movieVideosList :[VideosModel] = []
    var urlBase : String?
    var videoUrl : String?
    var favouriteMoveis :[MovieModel] = []
    var liked : UIImage?
    var unliked : UIImage?
    var isLiked = 0
    let coreModel = CoreModel.coreModel
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        liked = UIImage(named: "liked")
        unliked = UIImage(named: "unliked")
        favouriteBtn.setImage(liked, for: UIControl.State.selected)
        favouriteBtn.setImage(unliked, for: UIControl.State.normal)
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        var id = String(model.id as! Int)
        print("id \(id)")
        urlBase = "https://api.themoviedb.org/3/movie/\(id)/reviews?api_key=c69e24b3142fbe4565740ccc74c35fd7"
        videoUrl = "https://api.themoviedb.org/3/movie/\(id)/videos?api_key=c69e24b3142fbe4565740ccc74c35fd7"
        movieTitle.text = model.title
        movieDate.text = model.releaseDate
        movieImage.sd_setImage(with: URL(string: model.poster!), completed: nil)
        movieDescription.text = model.overView
        movieRate.rating = ((model.rating)as!Double)/2
        movieReviewsList = []
        netWorkModel.getMovieReviews(urlBase: urlBase!)
        netWorkModel.getMovieVideo(urlBase: videoUrl!)
        NotificationCenter.default.addObserver(self, selector: #selector(loadList(notification:)), name: NSNotification.Name(rawValue: "load reviews"), object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(loadVedios(notification:)), name: NSNotification.Name(rawValue: "load videos"), object: nil)
        
        favouriteBtn.isSelected = false
        isLiked=0
        favouriteMoveis = coreModel.fetchFavourite()
        if(favouriteMoveis.count != 0 )
        {
            
            for item in favouriteMoveis
            {
                if ( item.id == model.id)
                {
                    favouriteBtn.isSelected = true
                    isLiked = 1
                }
            }
        
        }
       
    }
    
    @IBAction func clickedOnFavourites(_ sender: Any) {
        
        if(isLiked == 0)
        {
            favouriteBtn.isSelected = true
            isLiked=1;
            coreModel.saveFavourite(model:model)
            print("save ")

        }
        else
        {
            favouriteBtn.isSelected = false
            isLiked = 0
            for item in favouriteMoveis
            {
                if ( item.id == model.id)
                {
                    coreModel.deleteItemFavourites(model: model)
                    print("delete ")
                }
            }
        }
    }
    @objc func loadList(notification: NSNotification) {
        movieReviewsList = notification.object as! Array
        print("count movieReviews = ",movieReviewsList.count)
        collectionView.reloadData()
    }
    @objc func loadVedios (notification: NSNotification) {
        movieVideosList = notification.object as! Array
        print("count moviesVedios= ",movieVideosList.count)
        movieDetails.reloadData()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return movieVideosList.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            var video = movieVideosList[indexPath.row]
            cell.textLabel?.text = video.name

            //var image = UIimage.
        var image = UIImage(named: "youtube")
        cell.imageView?.image = image
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            var video = movieVideosList[indexPath.row]
            var key = video.key as! String
            var youtubeUrl = URL(string:"youtube://\(key)")!
            print("you")
            print(youtubeUrl.absoluteString)
            if UIApplication.shared.canOpenURL(youtubeUrl){
                UIApplication.shared.openURL(youtubeUrl)
            } else{
                youtubeUrl = URL(string:"https://www.youtube.com/watch?v=\(key)")!
                print("link")
                print(youtubeUrl.absoluteString)
                UIApplication.shared.openURL(youtubeUrl)
            }
        
    }
    
  
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ReviewCell
        var review = movieReviewsList[indexPath.row]
        cell.reviewerComment.text = review.content
        cell.reviewerName.text = review.author
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieReviewsList.count
    }

}

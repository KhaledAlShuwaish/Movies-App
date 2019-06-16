//
//  DetailsViewController.swift
//  Elm_omdb
//
//  Created by Khaled Shuwaish on 24/03/2019.
//  Copyright © 2019 Khaled Shuwaish. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    var MoviewDetails :Movie!
    
    @IBOutlet weak var MoviewImage: UIImageView!
    @IBOutlet weak var MovieTitle: UILabel!
    @IBOutlet weak var MovieRating: UILabel!
    @IBOutlet weak var MovieType: UILabel!
    @IBOutlet weak var ReleasedDate: UILabel!
    @IBOutlet weak var MovieYear: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RequistDetailsAPI()
    }
    
    @IBAction func ShareButton(_ sender: Any) {
        let url = URL(string: MoviewDetails.Poster)
        let data = try? Data(contentsOf: url!)
        if let imageData = data {
            let image = UIImage(data: imageData)
            let ViewControler = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            self.present(ViewControler, animated: true, completion: nil)
            ViewControler.completionWithItemsHandler = {
                (activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
                if !completed  {
                    return
                }
                ViewControler.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func RequistDetailsAPI(){
            let BasedUrl = "http://www.omdbapi.com/?apikey=fd866ab2&i=\(MoviewDetails.imdbID)"
            let NewURL = BasedUrl.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
            URLSession.shared.dataTask(with: URL(string: NewURL!)!) { (data, response, error) in
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary
                    DispatchQueue.main.async {
                        self.MovieTitle.text = json.value(forKey: "Title") as? String
                        self.ReleasedDate.text = json.value(forKey: "Released") as? String
                        self.MovieType.text = json.value(forKey: "Genre") as? String
                        self.MovieRating.text = json.value(forKey: "imdbRating") as? String
                        self.MovieYear.text = json.value(forKey: "Year") as? String
                        let image = json.value(forKey: "Poster") as! String
                        self.LoadImage(Image: image, UIimage: self.MoviewImage)
                    }
                } catch {
                    print(error)
                }
                }.resume()
    }

    
    @IBAction func FavoriteButton(_ sender: Any) {
        var movie_Image = MoviewDetails.Poster
        var Movie_Title = MovieTitle.text as! String
        var Movie_Rating = MovieRating.text as! String
        var MovieT_ype = MovieType.text as! String
        var Released_Date = ReleasedDate.text as! String
        let movie = NewMovie(context: PersistenceServce.context)
        movie.title = Movie_Title
        movie.gener = MovieT_ype
        movie.released_ate = Released_Date
        movie.poster = movie_Image
        PersistenceServce.saveContext()
        FavoriteTableViewController.FavoriteMovie.append(movie)
    }
    
    func LoadImage(Image:String , UIimage : UIImageView)  {
        URLSession.shared.dataTask(with: URL(string: Image)!) { result, response, error in
            if error == nil {
                if let data = result {
                    DispatchQueue.main.async {
                        UIimage.image  = UIImage(data: data)
                    }
                }
            } else {
                print(error!)
            }
            }.resume()
    }
}


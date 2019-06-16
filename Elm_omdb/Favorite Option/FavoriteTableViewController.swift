//
//  FavoriteTableViewController.swift
//  Elm_omdb
//
//  Created by Khaled Shuwaish on 25/03/2019.
//  Copyright © 2019 Khaled Shuwaish. All rights reserved.
//

import UIKit
import CoreData
class FavoriteTableViewController: UITableViewController{
    @IBOutlet var Tableview: UITableView!
    
    static var FavoriteMovie  = [NewMovie]()
    override func viewDidLoad() {
        super.viewDidLoad()
        Tableview.delegate = self
        Tableview.dataSource = self
       
        
        let fetchRequest: NSFetchRequest<NewMovie> = NewMovie.fetchRequest()
        do {
            let Movie = try PersistenceServce.context.fetch(fetchRequest)
            FavoriteTableViewController.FavoriteMovie = Movie
           print( Movie.count)
            self.Tableview.reloadData()
        } catch {}
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        self.Tableview.reloadData()

    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavoriteTableViewController.FavoriteMovie.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell", for: indexPath) as! FavoriteTableViewCell
        cell.MovieTitle.text = FavoriteTableViewController.FavoriteMovie[indexPath.row].title
        let image = FavoriteTableViewController.FavoriteMovie[indexPath.row].poster
        LoadImage(Image: image!, cell: cell)
        cell.MovieGener.text = FavoriteTableViewController.FavoriteMovie[indexPath.row].gener
        cell.MovieDate.text = FavoriteTableViewController.FavoriteMovie[indexPath.row].released_ate
        cell.ShareButton.tag = indexPath.row
        cell.ShareButton.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        return cell
    }
    
    
    
    @IBAction func buttonAction(_ sender: UIButton) {
        
        
        let image = FavoriteTableViewController.FavoriteMovie[sender.tag].poster
        let url = URL(string: image!)
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
    
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete
        {
            let alert = UIAlertController(title: "Delete Movie", message: "Do you want to delete the movie", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
                DispatchQueue.main.async {
                    
                    let object = FavoriteTableViewController.FavoriteMovie[indexPath.row]
                    PersistenceServce.context.delete(object)
                    PersistenceServce.saveContext()
                    FavoriteTableViewController.FavoriteMovie.remove(at: indexPath.row)
                    self.Tableview.reloadData()
                    
                }
                
            }
            alert.addAction(cancelAction)
            alert.addAction(deleteAction)
            
            //Present the alert controller
            present(alert, animated: true, completion: nil)
            
           
        }
    }

    
    func LoadImage(Image:String , cell : FavoriteTableViewCell)  {
        URLSession.shared.dataTask(with: URL(string: Image)!) { result, response, error in
            if error == nil {
                if let data = result {
                    DispatchQueue.main.async {
                        cell.MovieImage.image = UIImage(data: data)
                    }
                }
            } else {
                print(error!)
            }
            }.resume()
    }
}



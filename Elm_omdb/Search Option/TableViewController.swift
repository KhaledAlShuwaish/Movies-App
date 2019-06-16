//
//  TableViewController.swift
//  Elm_omdb
//
//  Created by Khaled Shuwaish on 24/03/2019.
//  Copyright © 2019 Khaled Shuwaish. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {
    var movies = [Movie]()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var edittext: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        edittext.delegate = self
        self.hideKeyboardWhenTappedAround()
        
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func RequestAPI(){
        let BasedUrl = "http://www.omdbapi.com/?apikey=fd866ab2&s=\(edittext.text ?? "game")"
        let NewURL = BasedUrl.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        
        URLSession.shared.dataTask(with: URL(string: NewURL!)!) { (data, response, error) in
            do {
                guard let data = data else {
                    DispatchQueue.main.async {
                        ActivityIndicator.stopActivityIndicator()
                        self.alert(Message: "There is no movie with this name")
                    }
                    return
                }
                let list = try JSONDecoder().decode(MovieResult.self, from: data)
                self.movies = list.Search
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    ActivityIndicator.stopActivityIndicator()
                    if self.movies.count == 0 {
                        self.alert(Message: "There is no movie with this name")
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    ActivityIndicator.stopActivityIndicator()
                    self.alert(Message: "There is no movie with this name")
                }
            }
            }.resume()
    }
    
    @IBAction func SearchButton(_ sender: Any) {
        ActivityIndicator.startActivityIndicator(view: self.view)
         RequestAPI()
    }
    func alert(Message : String)  {
        let alert = UIAlertController(title: "Error", message: Message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
}




extension TableViewController :  UITableViewDelegate , UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.Movie_Title.text = movies[indexPath.row].Title
        
        let image = movies[indexPath.row].Poster
   
        LoadImage(Image: image, cell: cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let DetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        DetailsViewController.MoviewDetails = self.movies[indexPath.row]
        self.navigationController?.pushViewController(DetailsViewController, animated: true)
    }
    
    
    func LoadImage(Image:String , cell : TableViewCell)  {
        URLSession.shared.dataTask(with: URL(string: Image)!) { result, response, error in
            if error == nil {
                if let data = result {
                    DispatchQueue.main.async {
                        cell.Poster_Image.image = UIImage(data: data)
                    }
                }
            } else {
                print(error!)
            }
            }.resume()
    }
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
   
}

extension TableViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
}


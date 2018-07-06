//
//  ListViewController.swift
//  OMDb
//
//  Created by Ruchi Gadge on 01/07/18.
//  Copyright © 2018 Ruchi Gadge. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var listView: UITableView!
    @IBOutlet weak var navTitle: UILabel!
    
    var itemList = NSArray()
    var titleString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navTitle.text = titleString
        listView.delegate = self
        listView.dataSource = self
        listView.backgroundColor = UIColor(red: 52/255, green: 47/255, blue: 86/255, alpha: 1)
        print("Hello \(itemList)")
        listView.reloadData()
    }

    //MARK:- Tableview Datasource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ListTableViewCell
       
        if let title = (self.itemList.object(at: indexPath.row) as! NSDictionary).object(forKey: "Title") as? String {
            cell.title.text = title
        }

        if let year = (self.itemList.object(at: indexPath.row) as! NSDictionary).object(forKey: "Year") as? String {
            cell.year.text = year
        }
        
        if let imageURL = (self.itemList.object(at: indexPath.row) as! NSDictionary).object(forKey: "Poster") as? String {

            cell.posterImage.setImage(from: URL(string: imageURL)!, withPlaceholder: UIImage(named: "Star"))
        }
        
        return cell
    }
    
    //MARK:- Tableview Delegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        vc.imdbId = (self.itemList.object(at: indexPath.row) as! NSDictionary).object(forKey: "imdbID") as! String
        self.present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //MARK: - Back button pressed
    
    @IBAction func backPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}

//MARK:- Load image from URL

extension UIImageView {
    func setImage(from url: URL, withPlaceholder placeholder: UIImage? = nil) {
        self.image = placeholder
        URLSession.shared.dataTask(with: url) { data,_,_ in
            if let data = data {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }.resume()
    }
}

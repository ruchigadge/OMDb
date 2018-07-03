//
//  DetailsViewController.swift
//  OMDb
//
//  Created by Ruchi Gadge on 01/07/18.
//  Copyright © 2018 Ruchi Gadge. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var detailsTableView: UITableView!
    
    var movieTitle = String()
    var detailsDictionary = NSDictionary()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        print(movieTitle)
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
        
        let params : [String:String] = ["apikey": API_KEY,"t": movieTitle]
        getDetails(url: BASE_URL, parameters: params)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: DetailsTableViewCell!
        
        if detailsDictionary.count > 0 {
            if indexPath.section == 0 {
                cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! DetailsTableViewCell
                if let title = detailsDictionary.value(forKey: "Title") as? String {
                    cell.title.text = title
                }
                
                if let runtime = detailsDictionary.value(forKey: "Runtime") as? String, let genre = detailsDictionary.value(forKey: "Genre") as? String {
                    
                    cell.runtimeAndGenre.text = "\(String(describing: runtime)) | \(String(describing: genre))"
                }
                
                if let posterUrl = detailsDictionary.value(forKey: "Poster") as? String {
                    cell.posterImageView.setImage(from: URL(string: posterUrl)!, withPlaceholder: UIImage(named: "Star"))
                }
                
                if let rating = detailsDictionary.value(forKey: "imdbRating") as? String {
                    cell.rating.text = "\(rating)/10"
                }
                
            }
            else if indexPath.section == 1 {
                cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as! DetailsTableViewCell
                if let name = detailsDictionary.value(forKey: "Director") as? String {
                    cell.directorName.text = name
                }
                
            }
            else if indexPath.section == 2 {
                cell = tableView.dequeueReusableCell(withIdentifier: "cell3") as! DetailsTableViewCell
                if let date = detailsDictionary.value(forKey: "Released") as? String {
                    cell.releaseDate.text = date
                }
                
            }
            else {
                cell = tableView.dequeueReusableCell(withIdentifier: "cell4") as! DetailsTableViewCell
                if let storyline = detailsDictionary.value(forKey: "Plot") as? String {
                    cell.storyline.text = storyline
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if indexPath.section == 0 {
            return 276
        }else if indexPath.section == 1 {
            return 73
        }else if indexPath.section == 2 {
            return 73
        }else  {
            return UITableViewAutomaticDimension
        }        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    @IBAction func backPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func getDetails(url: String, parameters:[String:String]) {
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { response in
//            print(response)
            if response.result.isSuccess {
                let detailJSON = JSON(response.result.value as Any)
                print(detailJSON)
                if let tempResult = detailJSON.dictionaryObject {
                    self.detailsDictionary = tempResult as NSDictionary
                    print("Log1", tempResult)
                    self.detailsTableView.reloadData()
                }
            }else{
                print("Error \(String(describing: response.result.error))")
            }
        }
    }

}

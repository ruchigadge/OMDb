//
//  SearchViewController.swift
//  OMDb
//
//  Created by Ruchi Gadge on 23/06/18.
//  Copyright © 2018 Ruchi Gadge. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

//Constants
let BASE_URL = "http://www.omdbapi.com"
let API_KEY = "8af44a12"

class SearchViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    var itemList = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchButton.layer.cornerRadius = 5.0
    }
    
    
    //MARK: - Networking
    
    func getList(url: String, parameters:[String:String]) {
        let sv = UIViewController.displaySpinner(onView: self.view)
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { response in

            if response.result.isSuccess {
                UIViewController.removeSpinner(spinner: sv)
                let movieListJSON = JSON(response.result.value as Any)
                if let tempResult = movieListJSON["Search"].arrayObject {
                    self.itemList = tempResult as NSArray
                }
                if self.itemList.count != 0{
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
                    vc.itemList = self.itemList
                    vc.titleString = self.searchTextField.text!
                    self.present(vc, animated: true, completion: nil)
                }else {
                    let alert = UIAlertController(title: "", message: "Movie not found!", preferredStyle: .alert)
                    let hideAlert = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    alert.addAction(hideAlert)
                    self.present(alert, animated: true, completion: nil)
                }
                
            }else{
                UIViewController.removeSpinner(spinner: sv)
                let alert = UIAlertController(title: "", message: "Movie not found!", preferredStyle: .alert)
                let hideAlert = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alert.addAction(hideAlert)
                self.present(alert, animated: true, completion: nil)
//                print("Error \(String(describing: response.result.error))")
            }
        }
    }
    
    //MARK: - Search Button Pressed
    @IBAction func searchPressed(_ sender: Any) {
        
        if (searchTextField.text?.isEmpty)! {
            let alert = UIAlertController(title: "", message: "Please enter a title to search.", preferredStyle: .alert)
            let hideAlert = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(hideAlert)
            self.present(alert, animated: true, completion: nil)
        }else{
            let params : [String:String] = ["apikey": API_KEY,"s": searchTextField.text!]
            if Connectivity.isConnectedToInternet {
                getList(url: BASE_URL, parameters: params)
                searchTextField.text = ""
            }else {
                let alert = UIAlertController(title: "", message: "Please check your network connection.", preferredStyle: .alert)
                let hideAlert = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alert.addAction(hideAlert)
                self.present(alert, animated: true, completion: nil)
            }
            
        }        
    }
    

}


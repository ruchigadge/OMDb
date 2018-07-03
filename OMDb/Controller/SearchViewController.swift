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
        
    var itemList = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - Networking
    /********************************************************/
    
    func getList(url: String, parameters:[String:String]) {
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { response in
//            print(response)
            if response.result.isSuccess {
                let movieListJSON = JSON(response.result.value as Any)
                print(movieListJSON)
                if let tempResult = movieListJSON["Search"].arrayObject {
                    self.itemList = tempResult as NSArray
                }
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
                vc.itemList = self.itemList
                vc.titleString = self.searchTextField.text!
                self.present(vc, animated: true, completion: nil)
            }else{
                print("Error \(String(describing: response.result.error))")
            }
        }
    }
    /********************************************************/

    @IBAction func searchPressed(_ sender: Any) {
        let params : [String:String] = ["apikey": API_KEY,"s": searchTextField.text!]
        getList(url: BASE_URL, parameters: params)
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "searchMovie" {
//            let destinationVC = segue.destination as! ListViewController
//            destinationVC.itemList = self.movieArray
//            
//        }
//    }


}


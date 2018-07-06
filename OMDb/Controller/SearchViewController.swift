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

class SearchViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    var itemList = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        searchButton.layer.cornerRadius = 5.0
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SearchViewController.DismissKeyboard))
        view.addGestureRecognizer(tap)
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
    
    //MARK: - Dismiss Keyboard
    @objc func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    //MARK: - Move view when keyboard appears/disappears
    func animateViewMoving (_ up:Bool, moveValue :CGFloat){
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0,  dy: movement)
        UIView.commitAnimations()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        animateViewMoving(true, moveValue: 100)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        animateViewMoving(false, moveValue: 100)
    }
    
    //MARK: - Search Button Pressed
    @IBAction func searchPressed(_ sender: Any) {
        
        DismissKeyboard()
        
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


//
//  ViewController.swift
//  On The Map
//
//  Created by Zach Eidenberger on 8/22/17.
//  Copyright © 2017 ZacharyG. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var loginEmail = UITextField()
    @IBOutlet weak var loginPassword = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginEmail?.text = "Zacharyg88@gmail.com"
        loginPassword?.text = "Clue1388"
        loginEmail?.delegate = self
        loginPassword?.delegate = self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginPassword?.resignFirstResponder()
        loginEmail?.resignFirstResponder()
        return true
    }
    
    @IBAction func signUP() {
        performSegue(withIdentifier: "signUpSegue", sender: self)
    }
    
    @IBAction func login() {
        
        UdacityClient.sharedInstance().authenticateAppUser((loginEmail?.text)!, (loginPassword?.text)!) { (success, errorString) in
            
            if success {
                let userID = UdacityClient.udacityConstants.userID
                UdacityClient.sharedInstance().getFirstAndLastName(udacityID: userID, convenienceMethodForGetUserData: { (success, errorString) in
                    
                    if success {
                        ParseClient.sharedInstance().populateMap(convenienceMethodForHandlerForPopulateMap: { (success, errorString) in
                            if success{
                                OperationQueue.main.addOperation {
                                    self.performSegue(withIdentifier: "presentTabController", sender: self)
                                }
                                
                            }else {
                                let alert = UIAlertController(title: "Oops!", message: "There was a problem logging in. Please try again!", preferredStyle: UIAlertControllerStyle.alert)
                                alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.cancel, handler: nil))
                                    alert.addAction(UIAlertAction(title: "Sign Up!", style: UIAlertActionStyle.default, handler: { action in
                                        
                                        self.performSegue(withIdentifier: "signUpSegue", sender: self)
                                    }))
                                self.present(alert, animated: true, completion: nil)
                            }
                        
                         
                        print("Success!")
                        }
                    )}
                    else {
                        print("Failure")
                    }
                    
                })

            }
        }
    }
}

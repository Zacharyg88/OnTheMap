//
//  ViewController.swift
//  On The Map
//
//  Created by Zach Eidenberger on 8/22/17.
//  Copyright © 2017 ZacharyG. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var loginEmail = UITextField()
    @IBOutlet weak var loginPassword = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        loginEmail?.text = "Zacharyg88@gmail.com"
//        loginPassword?.text = ""
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func login() {
        
        UdacityClient.sharedInstance().authenticateAppUser((loginEmail?.text)!, (loginPassword?.text)!) { (success, errorString) in
            
            if success {
                let userID = UdacityClient.udacityConstants.userID
                //print("The User ID is \(userID)")
                UdacityClient.sharedInstance().getFirstAndLastName(udacityID: userID, convenienceMethodForGetUserData: { (success, errorString) in
                    
                    if success {
                        ParseClient.sharedInstance().populateMap(convenienceMethodForHandlerForPopulateMap: { (success, errorString) in
                            if success{
                                print("yay")
                                //MapViewController = [super.initWithNibName: "mapVC", bundle: nil]
                                OperationQueue.main.addOperation {
                                    self.performSegue(withIdentifier: "presentTabController", sender: self)
                                }
                                
                            }else {
                                print("Oh No")
                            }
                        })
                        print("Success!")
                    }else {
                        print("Failure")
                    }
                    
                })

            } else {
                print("There Was an Error Logging In")
            }
        }
    }
}

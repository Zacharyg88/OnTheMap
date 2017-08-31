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
        loginEmail?.text = "Zacharyg88@gmail.com"
        loginPassword?.text = "Clue1388"
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                                    self.performSegue(withIdentifier: "presentNavigationController", sender: self)
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
                // find out if user has a student location in Parse ; store object ID of location
                
                // get the last 100 student locations in Parse; store student locations from Parse
                
                
            } else {
                // display error string in UIAlertView
            }
        }
    }
}

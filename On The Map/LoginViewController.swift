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
    @IBOutlet weak var activityIndicator = UIActivityIndicatorView()
    @IBOutlet weak var loginView = UIView()
    var successfulParse = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginEmail?.delegate = self
        loginPassword?.delegate = self
        activityIndicator?.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        subscribeToKeyboardNotifications()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        unsubcribeToKeyboardNotificaitons()
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
        if Reachability.isConnectedToInternet() == true {
        performSegue(withIdentifier: "signUpSegue", sender: self)
        }else {
            let alert = UIAlertController(title: "Not Connected to Internet!", message: "You have to be connected to the internet in order to use this app.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: { action in
                self.dismiss(animated: true, completion: nil)
                
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func login() {
        activityIndicator?.isHidden = false
        activityIndicator?.startAnimating()
        loginPassword?.resignFirstResponder()
        loginEmail?.resignFirstResponder()
        if Reachability.isConnectedToInternet() == true {
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
                                    alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.cancel, handler: { action in
                                        self.activityIndicator?.stopAnimating()
                                        self.activityIndicator?.isHidden = true
                                        self.loginEmail?.text = ""
                                        self.loginPassword?.text = ""
                                    }))
                                    alert.addAction(UIAlertAction(title: "Sign Up!", style: UIAlertActionStyle.default, handler: { action in
                                        self.performSegue(withIdentifier: "signUpSegue", sender: self)
                                    }))
                                    self.present(alert, animated: true, completion: nil)
                                }
                                self.activityIndicator?.stopAnimating()
                                print("Success!")
                            }
                            )}
                        else {
                            
                            let alert = UIAlertController(title: "Oops!", message: "There was a problem loggin in. Please try again!", preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.cancel, handler: nil))
                            alert.addAction(UIAlertAction(title: "Sign Up!", style: UIAlertActionStyle.default, handler: { action in
                                self.performSegue(withIdentifier: "signUpSegue", sender: self)
                            }))
                            self.present(alert, animated: true, completion: nil)
                        }
                    })
                } else {
                    let alert = UIAlertController(title: "Login Failed", message: "Couldn't authenticate with the given information, please try again!", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.cancel, handler: { action in                    self.activityIndicator?.isHidden = true
                        self.activityIndicator?.stopAnimating()
                    }))
                    alert.addAction(UIAlertAction(title: "Sign Up!", style: UIAlertActionStyle.default, handler: { action in
                        self.activityIndicator?.isHidden = true
                        self.activityIndicator?.stopAnimating()
                        self.performSegue(withIdentifier: "signUpSegue", sender: self)
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }else {
            
            let alert = UIAlertController(title: "Not Connected to Internet!", message: "You have to be connected to the internet in order to use this app.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: { action in
                self.dismiss(animated: true, completion: nil)
                
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
        
    }
    
    func keyboardWillShow(_ notification: Notification) {
        loginView?.frame.origin.y = 0 - getKeyboardHeight(notification)
    }
    
    func keyboardWillHide (_ notification: Notification) {
        
        loginView?.frame.origin.y = 0.0
    }
    
    
    
    func subscribeToKeyboardNotifications () {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    func unsubcribeToKeyboardNotificaitons () {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
}

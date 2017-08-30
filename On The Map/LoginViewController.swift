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
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func login() {
        
        UdacityClient.sharedInstance().authenticateAppUser((loginEmail?.text)!, (loginPassword?.text)!) { (success, errorString) in
            
            if success {
                // find out if user has a student location in Parse ; store object ID of location
                
                // get the last 100 student locations in Parse; store student locations from Parse
                
                
            } else {
                // display error string in UIAlertView
            }
        }
        
        let request = NSMutableURLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpBody = "{\"udacity\": {\"username\": \"\((self.loginEmail?.text)! as String)\", \"password\": \"\((self.loginPassword?.text)! as String)\"}}".data(using: String.Encoding.utf8)
request.httpBody = "{\"udacity\": {\"username\": \"zacharyg88@gmail.com\", \"password\": \"Clue1388\"}}".data(using: String.Encoding.utf8)        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            if error != nil {
                print(error as Any)
                return
            }
            let range = Range(5..<data!.count)
            let newData = data?.subdata(in: range)
          
            print(NSString(data: newData!, encoding: String.Encoding.utf8.rawValue) as Any)
            
            var parsedResults = [String:AnyObject]()
            do {
            parsedResults = try JSONSerialization.jsonObject(with: newData!, options: .allowFragments) as! [String:AnyObject]
            print(parsedResults)
            } catch {
                print("oops!")
                return
            }
            
            
    }
        task.resume()
    }
    
  
    
}


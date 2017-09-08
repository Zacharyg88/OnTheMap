//
//  TableViewController.swift
//  On The Map
//
//  Created by Zach Eidenberger on 8/31/17.
//  Copyright © 2017 ZacharyG. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var logoutButton = UIBarButtonItem()
    

    let students = ParseClient.parseConstants.studentLocations


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let student = students[(indexPath as NSIndexPath).row]
        
        cell?.textLabel?.text = "\(student["lastName"] as! String, (student["firstName"]) as! String)"
        cell?.detailTextLabel?.text = "\(student["mediaURL"] as! String)"
        
        return cell!
    }

    @IBAction func logout() {
        UdacityClient.sharedInstance().logoutOfUdacity { (success, errorString) in
            if success {
                self.performSegue(withIdentifier: "logoutSegue", sender: self)
                
            } else {
                print("Couldn't Logout")
            }
        }
    }
}

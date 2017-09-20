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
    @IBOutlet weak var tableView = UITableView()
    @IBOutlet weak var dropPinButton = UIBarButtonItem()
    

    let students = ParseClient.parseConstants.studentLocations
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.reloadData()
    
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        ParseClient.parseConstants.currentMediaURL = (cell?.detailTextLabel?.text)!
        performSegue(withIdentifier: "mediaURLSegue", sender: self)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        var sortedStudents = students.sorted { (student1, student2) in
            var Return = Bool()
            if student1.updatedAt != "" && student2.updatedAt != "" {
                if student1.updatedAt > student2.updatedAt {
                    Return = true
                }else {
                    Return = false
                }
            }else {
                if student1.createdAt > student2.createdAt {
                    Return = true
                }else {
                    Return = false
                }
            }
            return Return
        }
        print(sortedStudents)
        
        
        let student = sortedStudents[(indexPath as NSIndexPath).row] 
        if student.lastName != "" && student.firstName != "" && student.mediaURL != "" {
            cell?.textLabel?.text = (("\((student.firstName)) \((student.lastName))") )
        cell?.detailTextLabel?.text = "\((student.mediaURL))"
        }
        return cell!
    }
    @IBAction func dropPin() {
        performSegue(withIdentifier: "dropPinSegue", sender: self)
    }

    @IBAction func logout() {
        UdacityClient.sharedInstance().logoutOfUdacity { (success, errorString) in
            if success {
                self.dismiss(animated: true, completion: nil)
                
            } else {
                print("Couldn't Logout")
            }
        }
    }
}

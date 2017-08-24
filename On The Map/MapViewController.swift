//
//  MapViewController.swift
//  On The Map
//
//  Created by Zach Eidenberger on 8/23/17.
//  Copyright © 2017 ZacharyG. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView = MKMapView()
    @IBOutlet weak var logoutButton = UIBarButtonItem()
    @IBOutlet weak var refreshButton = UIBarButtonItem()
    @IBOutlet weak var dropPinButton = UIBarButtonItem()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateMap()
        
        
    }
    
    func populateMap() {
        
        let parseURL = URL(string: "https://parse.udacity.com/parse/classes/StudentLocation?limit=100")
        
        let request = NSMutableURLRequest(url:parseURL!)
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            if error != nil {
                print(error as Any)
                return
            }
            //print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue) as Any)
            
            var parsedResults = [String:AnyObject]()
            do {
                parsedResults = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: AnyObject]
            }catch {
                print("oops!")
                return
            }
            print(parsedResults)
            mapView?.addAnnotation()
        
        
        
        
        
        }
        task.resume()
        
        
      
        
        
        
        
        
    }
    
    

}

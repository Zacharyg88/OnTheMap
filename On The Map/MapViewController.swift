//
//  MapViewController.swift
//  On The Map
//
//  Created by Zach Eidenberger on 8/23/17.
//  Copyright © 2017 ZacharyG. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
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
        
        var request = NSMutableURLRequest(url:parseURL!)
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            if error != nil {
                print(error as Any)
                return
            }
            //print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue) as Any)
            
            var parsedResults = [String:Any]()
            do {
                parsedResults = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: Any]
            }catch {
                print("oops!")
                return
            }
            print(parsedResults)
           // self.mapView?.animatesDrop = true
            var pins = [MKAnnotation]()
            
//            for i in parsedResults {
//                let lat = CLLocationDegrees(i["latitude"] as! Double)
//                let lon = CLLocationDegrees(i["longitude"] as! Double)
//                
//                let latlon = CLLocationCoordinate2D(latitude: lat, longitude: lon)
//                
//                let userName = "\(i["firstName"] as! String, i["lastName"] as! String)"
//                let userSite = i["mediaURL"] as! String
//                
//                
//                let pin = MKPointAnnotation()
//                pin.coordinate = latlon
//                pin.title = userName
//                pin.subtitle = userSite
//                
//                
//                pins.append(pin)
//            }
//            self.mapView?.addAnnotations(pins)
          
                
                
            
        
        
        
        
        
        
        
        }
        task.resume()
        
        
      
        
        
        
        
        
    }
    
    

}

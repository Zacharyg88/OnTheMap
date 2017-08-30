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
        var pins = [MKAnnotation]()
        
        for studentLocation in ParseClient.parseConstants.studentLocations {
            let lat = CLLocationDegrees(studentLocation["latitude"] as! Double)
            let lon = CLLocationDegrees(studentLocation["longitude"] as! Double)
            
            let latlon = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            
            let userName = "\(studentLocation["firstName"] as! String, studentLocation["lastName"] as! String)"
            let userSite = studentLocation["mediaURL"] as! String
            
            
            let pin = MKPointAnnotation()
            pin.coordinate = latlon
            pin.title = userName
            pin.subtitle = userSite
            
            
            pins.append(pin)
        }
        self.mapView?.addAnnotations(pins)
        

        
        
    }
    

    
    
    
        @IBAction func logout() {
            UdacityClient.sharedInstance().logoutOfUdacity { (success, errorString) in
                if success {
                    
                } else {
                    
                }
            }
        }
        
        
        
        
    }
    
    



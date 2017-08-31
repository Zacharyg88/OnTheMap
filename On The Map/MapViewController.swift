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
    }
    override func viewWillAppear(_ animated: Bool) {
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
            print("The Student Location as Pins is = \(pins)")
        }
        self.mapView?.addAnnotations(pins)
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            let reuseId = "pin"
            
            var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
            
            if pinView == nil {
                pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                pinView!.canShowCallout = true
                pinView!.pinTintColor = .red
                pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            }
            else {
                pinView!.annotation = annotation
            }
            
            return pinView
        }
        
        
        // This delegate method is implemented to respond to taps. It opens the system browser
        // to the URL specified in the annotationViews subtitle property.
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            if control == view.rightCalloutAccessoryView {
                let app = UIApplication.shared
                if let toOpen = view.annotation?.subtitle! {
                    //app.openURL(URL(string: toOpen)!)
                    app.open(URL(string: toOpen)!, options: [String:AnyObject](), completionHandler: nil)
                }
            }
        }

    }
    

    
    
    
        @IBAction func logout() {
            UdacityClient.sharedInstance().logoutOfUdacity { (success, errorString) in
                if success {
                    
                    
                } else {
                    
                }
            }
        }
        
        
        
        
    }
    
    



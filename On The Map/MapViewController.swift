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
    @IBOutlet weak var dropPinButton = UIBarButtonItem()

    
    let mediaWebView = mediaURLWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView?.delegate = self
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("map view select function working")
       view.canShowCallout = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(calloutTapped(sender:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        view.removeGestureRecognizer((view.gestureRecognizers?.first)!)
    }
    
    func calloutTapped(sender: UITapGestureRecognizer) {
        let view = sender.view as! MKAnnotationView
        if let annotation = view.annotation as? MKPointAnnotation {
            ParseClient.parseConstants.currentMediaURL = annotation.subtitle!
            performSegue(withIdentifier: "mediaURLSegue", sender: annotation)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        var pins = [MKAnnotation]()
        
        for studentLocation in ParseClient.parseConstants.studentLocations {
            print(studentLocation)
            if let latitude = studentLocation["latitude"] as? Double {
                if let longitude = studentLocation["longitude"] as? Double {
                    let lat = CLLocationDegrees(latitude)
                    let lon = CLLocationDegrees(longitude)
            
                    let latlon = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            
                    let userName = "\(studentLocation["firstName"] as! String, studentLocation["lastName"] as! String)"
                    let userSite = studentLocation["mediaURL"] as! String
            
            
                    let pin = MKPointAnnotation()
                    pin.coordinate = latlon
                    pin.title = userName
                    pin.subtitle = userSite
            
            
                    pins.append(pin)
                }
            }
        }
        ParseClient.parseConstants.pins = pins
        self.mapView?.addAnnotations(pins)
                
            
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            let reuseId = "pin"
            
            var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
            
            if pinView == nil {
                pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                pinView!.canShowCallout = true
                pinView!.pinTintColor = .red
                pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
                pinView!.rightCalloutAccessoryView?.backgroundColor = UIColor.cyan
            }
            else {
                pinView!.annotation = annotation
            }
            
            return pinView
        }

        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            if control == view.rightCalloutAccessoryView {
                let app = UIApplication.shared
                if let toOpen = view.annotation?.subtitle! {
                    app.open(URL(string: toOpen)!, options: [String:AnyObject](), completionHandler: nil)
                }
            }
        }
        
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
    
    @IBAction func showDropPinController () {
        performSegue(withIdentifier: "ShowDropPinView", sender: self)
    }
    
    
    
    
    
    
}





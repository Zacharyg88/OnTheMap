//
//  DropPinViewController.swift
//  On The Map
//
//  Created by Zach Eidenberger on 9/12/17.
//  Copyright © 2017 ZacharyG. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class DropPinViewController: UIViewController, UITextFieldDelegate, DropPinGeocodeDelegate {
    
    @IBOutlet weak var dropPinMapView = MKMapView()
    @IBOutlet weak var locationTextField = UITextField()
    @IBOutlet weak var urlTextField = UITextField()
    @IBOutlet weak var studyingTextField = UITextView()
    @IBOutlet weak var findLocationButton = UIButton()
    @IBOutlet weak var findLocationView = UIView()
    @IBOutlet weak var submitView = UIView()
    
    let locationManager = CLLocationManager()
    
    let DropPinGeoCoder = DropPinGeocoder()
    var studentUserInfo = [String: AnyObject]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationTextField?.becomeFirstResponder()
        locationTextField?.text = "Grand Rapids Michigan"
        locationTextField?.delegate = self
        urlTextField?.delegate = self
        DropPinGeoCoder.delegate = self
        submitView?.isHidden = true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        locationTextField?.resignFirstResponder()
        urlTextField?.resignFirstResponder()
        return true
    }
    
    
    @IBAction func searchLocation() -> Void {
        studentUserInfo = DropPinGeoCoder.forwardGeocoding(address: (locationTextField?.text)!)
    }
    
    func onFinishGeocode(_ userInfo: [String : AnyObject]) {
        
        findLocationView?.isHidden = true
        submitView?.isHidden = false
        UdacityClient.udacityConstants.mapString = (locationTextField?.text)! as String
        
        let pin = MKPointAnnotation()
        pin.coordinate = CLLocationCoordinate2D(latitude: userInfo["latitude"] as! CLLocationDegrees, longitude: userInfo["longitude"] as! CLLocationDegrees)
        dropPinMapView?.addAnnotation(pin)
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(pin.coordinate, 1000, 1000)
        dropPinMapView?.setRegion(coordinateRegion, animated: true)
        studentUserInfo["longitude"] = userInfo["longitude"]
        studentUserInfo["latitude"] = userInfo["latitude"]
        studentUserInfo["firstName"] = UdacityClient.udacityConstants.firstName as AnyObject?
        studentUserInfo["lastName"] = UdacityClient.udacityConstants.lastName as AnyObject?
    }
    
    @IBAction func submitUserInfo() {
        if urlTextField?.text != "" {
            studentUserInfo["mediaURL"] = urlTextField?.text as AnyObject?
            ParseClient.parseConstants.studentLocations.append(studentUserInfo)
            ParseClient.sharedInstance().taskForPostStudentLocation(userInfo: studentUserInfo) { (results, error) in
                if error != nil {
                    let alert = UIAlertController(title: "Oops!", message: "There was an error adding your location to the Parse Servers. Please try again.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: { action in
                        self.studentUserInfo["latitude"] = nil
                        self.studentUserInfo["longitude"] = nil
                        self.submitView?.isHidden = true
                        self.findLocationView?.isHidden = false
                        self.locationTextField?.text = ""
                        return
                    }))
                }else {
                    self.dismiss(animated: true, completion: nil)
                    
                }
            }
        }
    }
}


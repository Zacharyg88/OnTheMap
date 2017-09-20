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
    @IBOutlet weak var activityIndicator = UIActivityIndicatorView()
    
    
    @IBAction func cancelDropPin() {
        dismiss(animated: true, completion: nil)
    }
    
    let locationManager = CLLocationManager()
    
    let DropPinGeoCoder = DropPinGeocoder()
    let tableViewController = TableViewController()
    let parseClient = ParseClient()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationTextField?.becomeFirstResponder()
        locationTextField?.delegate = self
        urlTextField?.delegate = self
        DropPinGeoCoder.delegate = self
        submitView?.isHidden = true
        activityIndicator?.isHidden = true
        urlTextField?.text = "https://www.google.com"
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        locationTextField?.resignFirstResponder()
        urlTextField?.resignFirstResponder()
        return true
    }
    
    func reloadView() {
        locationTextField?.text = ""
        submitView?.isHidden = true
        findLocationView?.isHidden = false
    }
    
    @IBAction func searchLocation() -> Void {
        activityIndicator?.isHidden = false
        activityIndicator?.startAnimating()
        var studentLocation = DropPinGeoCoder.forwardGeocoding(address: (locationTextField?.text)!)
        ParseClient.parseConstants.currentStudentInformation.mapString = (locationTextField?.text)!
    }
    
    func onFinishGeocode(_ userInfo: [String : AnyObject]) {
        
        findLocationView?.isHidden = true
        submitView?.isHidden = false
        activityIndicator?.stopAnimating()
        activityIndicator?.isHidden = true
        UdacityClient.udacityConstants.mapString = (locationTextField?.text)! as String
        
        let pin = MKPointAnnotation()
        pin.coordinate = CLLocationCoordinate2D(latitude: userInfo["latitude"] as! CLLocationDegrees, longitude: userInfo["longitude"] as! CLLocationDegrees)
        dropPinMapView?.addAnnotation(pin)
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(pin.coordinate, 1000, 1000)
        dropPinMapView?.setRegion(coordinateRegion, animated: true)
        ParseClient.parseConstants.currentStudentInformation.longitude = userInfo["longitude"] as! Double
        ParseClient.parseConstants.currentStudentInformation.latitude = userInfo["latitude"] as! Double
        ParseClient.parseConstants.currentStudentInformation.firstName = UdacityClient.udacityConstants.firstName
        ParseClient.parseConstants.currentStudentInformation.lastName = UdacityClient.udacityConstants.lastName
        
    }
    
    @IBAction func submitUserInfo() {
        activityIndicator?.isHidden = false
        activityIndicator?.startAnimating()
        submitView?.isOpaque = true
        
        
        let isPreexistingUser = ParseClient.parseConstants.studentLocations.filter{$0.firstName == ParseClient.parseConstants.currentStudentInformation.firstName && $0.lastName == ParseClient.parseConstants.currentStudentInformation.lastName}
        print(isPreexistingUser)
        
        
        if isPreexistingUser.count > 0 {
            print(isPreexistingUser.count)
            let currentUserIndex = ParseClient.parseConstants.studentLocations.index(where: {$0.firstName == ParseClient.parseConstants.currentStudentInformation.firstName && $0.lastName == ParseClient.parseConstants.currentStudentInformation.lastName})
            print((currentUserIndex)!)

            if (urlTextField?.text != "") {
                ParseClient.parseConstants.studentLocations.remove(at: currentUserIndex!)
                ParseClient.parseConstants.currentStudentInformation.mediaURL = (urlTextField?.text)!
                
                ParseClient.sharedInstance().taskForPutStudentLocation(userInfo: ParseClient.parseConstants.currentStudentInformation) { (results, error) in
                    if error != nil {
                        let alert = UIAlertController(title: "Couldn't edit users parse data", message: "We were unable to edit your data. Please try again.", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.cancel, handler: { action in
                            self.activityIndicator?.stopAnimating()
                            self.activityIndicator?.isHidden = true
                            ParseClient.parseConstants.currentStudentInformation.latitude = 0
                            ParseClient.parseConstants.currentStudentInformation.longitude = 0
                            self.submitView?.isHidden = true
                            self.findLocationView?.isHidden = false
                            self.locationTextField?.text = ""
                            return
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }else {
                        ParseClient.parseConstants.currentStudentInformation.updatedAt = (results["updatedAt"] as! String)
                        ParseClient.parseConstants.studentLocations.append(ParseClient.parseConstants.currentStudentInformation)
                        print("successfully edited user information")
                        
                        self.dismiss(animated: true, completion: nil)
                    }
            }
            
            }
        }else {
            if (urlTextField?.text != "") {
                ParseClient.parseConstants.currentStudentInformation.mediaURL = (urlTextField?.text)!
                
                
                ParseClient.sharedInstance().taskForPostStudentLocation(userInfo: ParseClient.parseConstants.currentStudentInformation) { (results, error) in
                    if error != nil {
                        let alert = UIAlertController(title: "Oops!", message: "There was an error adding your location to the Parse Servers. Please try again.", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: { action in
                            self.activityIndicator?.stopAnimating()
                            self.activityIndicator?.isHidden = true
                            ParseClient.parseConstants.currentStudentInformation.latitude = 0
                            ParseClient.parseConstants.currentStudentInformation.longitude = 0
                            self.submitView?.isHidden = true
                            self.findLocationView?.isHidden = false
                            self.locationTextField?.text = ""
                            return
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }else {
                        
                        
                        ParseClient.parseConstants.currentStudentInformation.createdAt = (results["createdAt"] as! String)
                        ParseClient.parseConstants.objectID = (results["objectId"] as! String)
                        print(ParseClient.parseConstants.currentStudentInformation)
                        
                        
                        ParseClient.parseConstants.studentLocations.append(ParseClient.parseConstants.currentStudentInformation)
                        print("successfully posted user information")
                        self.dismiss(animated: true, completion: nil)
                        
                    }
                }
            }
        }
    }
    
}


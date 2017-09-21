//
//  GeoCoder.swift
//  On The Map
//
//  Created by Zach Eidenberger on 9/12/17.
//  Copyright © 2017 ZacharyG. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol DropPinGeocodeDelegate {
    func onFinishGeocode(_ userInfo: [String:AnyObject], _ hasError: Bool)
}

class DropPinGeocoder: CLGeocoder {
    var delegate: DropPinGeocodeDelegate?
    
    func forwardGeocoding(address: String) -> ([String: AnyObject], Bool)  {
        var userInfo = [String: AnyObject]()
        var hasError = Bool()
        CLGeocoder().geocodeAddressString(address) { (placemarks, error) in
            if error != nil {
                print("\(error)")
            }
            if placemarks != nil {
            if (placemarks?.count)! > 0 {
                let placemark = placemarks?[0]
                let location = placemark?.location
                let coordinate = location?.coordinate
                let latitude = coordinate?.latitude
                let longitude = coordinate?.longitude
                userInfo["latitude"] = latitude as AnyObject?
                userInfo["longitude"] = longitude as AnyObject?
                hasError = false
                
                self.delegate?.onFinishGeocode(userInfo, hasError)
                
            }else {
                print("didn't find anything")
            }
            }else {
                let alert = UIAlertController(title: "Couldn't Find Your Location", message: "There was a problem finding the location you entered. Please try again.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.cancel, handler: { action in
                    
                    }))
                hasError = true
                self.delegate?.onFinishGeocode(userInfo, true)
                print("bad search string")
                
            
            }
        }
        
    return (userInfo, hasError)
    }
    
}


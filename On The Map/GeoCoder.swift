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
    func onFinishGeocode(_ userInfo: [String:AnyObject])
}

class DropPinGeocoder: CLGeocoder {
    var delegate: DropPinGeocodeDelegate?
    
    func forwardGeocoding(address: String) -> [String: AnyObject]  {
        var userInfo = [String: AnyObject]()
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
                
                
                self.delegate?.onFinishGeocode(userInfo)
                
            }else {
                print("didn't find anything")
            }
            }else {
                print("bad search string")
            
            }
        }
        
    return userInfo
    }
    
}


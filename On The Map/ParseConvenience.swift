//
//  ParseConvenience.swift
//  On The Map
//
//  Created by Zach Eidenberger on 8/30/17.
//  Copyright © 2017 ZacharyG. All rights reserved.
//

import UIKit

extension ParseClient  {
    
    func populateMap(convenienceMethodForHandlerForPopulateMap: @escaping (_ success: Bool, _ errorString: String) -> Void) {
        
        ParseClient.sharedInstance().taskForGetStudentLocations { (studentLocations, error) in
        
            if error != nil {
                convenienceMethodForHandlerForPopulateMap(false, "Couldn't Parse Student Location Data")
            }else{
            parseConstants.studentLocations = studentLocations as! [[String : AnyObject]]
                
//                var pins = [MKAnnotation]()
//                
//                for studentLocation in ParseClient.parseConstants.studentLocations {
//                    let lat = CLLocationDegrees(studentLocation["latitude"] as! Double)
//                    let lon = CLLocationDegrees(studentLocation["longitude"] as! Double)
//                    
//                    let latlon = CLLocationCoordinate2D(latitude: lat, longitude: lon)
//                    
//                    let userName = "\(studentLocation["firstName"] as! String, studentLocation["lastName"] as! String)"
//                    let userSite = studentLocation["mediaURL"] as! String
//                    
//                    
//                    let pin = MKPointAnnotation()
//                    pin.coordinate = latlon
//                    pin.title = userName
//                    pin.subtitle = userSite
//                    
//                    
//                    pins.append(pin)
                }
                //self.mapView?.addAnnotations(pins)
                
                convenienceMethodForHandlerForPopulateMap(true, "")
            //}
        }
        
    }
    
}

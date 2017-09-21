//
//  ParseConstants.swift
//  On The Map
//
//  Created by Zach Eidenberger on 8/30/17.
//  Copyright © 2017 ZacharyG. All rights reserved.
//

import UIKit

extension ParseClient {
    
    struct parseConstants {
        static var studentLocations = [studentInformation]() 
        static var pins = [AnyObject]()
        static var currentMediaURL = String()
        static var objectID = String()
        static var currentStudentInformation = studentInformation(fromDictionary: [String:AnyObject]())
    }
    
    struct studentInformation {
        var firstName: String
        var lastName: String
        var mediaURL: String
        var createdAt: String
        var updatedAt: String
        var latitude: Double
        var longitude: Double
        var mapString: String
        
        init(fromDictionary studentDict: [String: AnyObject]){
            
            firstName = studentDict["firstName"] as? String ?? ""
            lastName = studentDict["lastName"] as? String ?? ""
            mediaURL = studentDict["mediaURL"] as? String ?? ""
            createdAt = studentDict["createdAt"] as? String ?? ""
            updatedAt = studentDict["updatedAt"] as? String ?? ""
            latitude = studentDict["latitude"] as? Double ?? 0
            longitude = studentDict["longitude"] as? Double ?? 0
            mapString = studentDict["mapString"] as? String ?? ""
        }
    }
}

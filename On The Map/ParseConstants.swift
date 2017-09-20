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
        static var currentStudentInformation = studentInformation(firstName: "", lastName: "", mediaURL: "", createdAt: "", updatedAt: "", latitude: 0, longitude: 0, mapString: "")
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
    }    
}

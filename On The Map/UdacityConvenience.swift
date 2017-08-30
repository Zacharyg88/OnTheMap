//
//  UdacityConvenience.swift
//  On The Map
//
//  Created by Zach Eidenberger on 8/29/17.
//  Copyright © 2017 ZacharyG. All rights reserved.
//

import UIKit


// MARK: TODO - Design/ create the convenience methods needed by the Login View Controller
extension UdacityClient {
    
    // MARK: TODO - Create a convenience method for authenticating the app user as a Udacity student
    // WHen successful, I have saved user's ID, session ID
    func authenticateAppUser (_ email: String, _ password: String, convenienecMethodForAuthenticateAppUser: (_ success: Bool, _ errorString:String) -> Void) {
        
        // prep for taskForPostSession()

        // call taskForPostSession
        taskForPostSession(email, password) { (parsedResult, error) in
            
          // using guard statement or other tests, if there's no error and the parsedResult is valid
            //extract account id and store as user's udacityID in UdacityClient
            //extract session id and store in UdacityClient
            
         //either way, call convenienecMethodForAuthenticateAppUser  and pass appropriate data
            
        }
    
    }

    
    // MARK: TODO - create a convenience method for retrieving the first_name and last_name from the Public User Data
    // WHen succssful, I ahve saved the user's first_name and last_name
    func getFirstAndLastName ( udacityID:String) {
        
    }
    
    // MARK: TODO - create a convenience method for logging out of Udacity
    func logoutOfUdacity() {
        
    }
    
    
}

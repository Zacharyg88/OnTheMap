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
    func authenticateAppUser (_ email: String, _ password: String, convenienecMethodForAuthenticateAppUser: @escaping (_ success: Bool, _ errorString:String) -> Void) {
        
        // prep for taskForPostSession()

        // call taskForPostSession
        taskForPostSession(email, password) { (parsedResult, error) in
            
          // using guard statement or other tests, if there's no error and the parsedResult is valid
            if error != nil {
                print("\(error)")
            }else {
            var sessionData = parsedResult?["session"] as! [String: AnyObject]
            var accountData = parsedResult?["account"] as! [String: AnyObject]
                
                udacityConstants.userID = accountData["key"] as! String
                print(" The user ID is \(udacityConstants.userID) ")
                udacityConstants.sessionID = sessionData["id"] as! String
                print("The Session ID is \(udacityConstants.sessionID)")
                var registered = Bool()
                registered = accountData["registered"] as! Bool
                    if registered == true{
                    convenienecMethodForAuthenticateAppUser(true, "")
                    
                }else{
                    convenienecMethodForAuthenticateAppUser(false,"\(error)")
                }
            
            
         //either way, call convenienecMethodForAuthenticateAppUser  and pass appropriate data
            
        }
    
    }
    }

    
    // MARK: TODO - create a convenience method for retrieving the first_name and last_name from the Public User Data
    // WHen succssful, I ahve saved the user's first_name and last_name
    func getFirstAndLastName ( udacityID:String, convenienceMethodForGetUserData: @escaping (_ success: Bool, _ errorString: String) -> Void) {
        taskForGetPublicUserData(udacityID) { (parsedResult, error) in
            
            if error != nil {
                convenienceMethodForGetUserData(false, "There was an Error at GetFirstAndLastName")
            }else {
                let firstName = parsedResult?["first_name"] as! String
                let userInfo = parsedResult?["user"] as AnyObject
                let lastName = userInfo["last_name"] as! String
                
                udacityConstants.firstName = firstName
                print(udacityConstants.firstName)
                udacityConstants.lastName = lastName
                print(udacityConstants.lastName)
                
                convenienceMethodForGetUserData(true, "")
            }
            
            
        }
        
    }
    
    // MARK: TODO - create a convenience method for logging out of Udacity
    func logoutOfUdacity(convenienceMethodForDeleteSession: @escaping (_ success: Bool, _ errorString: String) -> Void) {
        
        taskForDeleteSession{ (parsedResult, error) in
            if error != nil {
                convenienceMethodForDeleteSession(false, "Error Occurred During Delete Session")
            } else {
                convenienceMethodForDeleteSession(true, "")
            }
        }
    }
}

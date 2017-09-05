//
//  UdacityConvenience.swift
//  On The Map
//
//  Created by Zach Eidenberger on 8/29/17.
//  Copyright © 2017 ZacharyG. All rights reserved.
//

import UIKit



extension UdacityClient {
    

    func authenticateAppUser (_ email: String, _ password: String, convenienecMethodForAuthenticateAppUser: @escaping (_ success: Bool, _ errorString:String) -> Void) {

        taskForPostSession(email, password) { (parsedResult, error) in
            
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
            }
        }
    }
    func getFirstAndLastName ( udacityID:String, convenienceMethodForGetUserData: @escaping (_ success: Bool, _ errorString: String) -> Void) {
        taskForGetPublicUserData(udacityID) { (parsedResult, error) in
            
            if error != nil {
                convenienceMethodForGetUserData(false, "There was an Error at GetFirstAndLastName")
            }else {
                let userInfo = parsedResult?["user"] as AnyObject
                let firstName = userInfo["first_name"] as! String
                let lastName = userInfo["last_name"] as! String
                
                
                udacityConstants.firstName = firstName
                udacityConstants.lastName = lastName
                
                convenienceMethodForGetUserData(true, "")
            }
        }
    }
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

//
//  UdacityClient.swift
//  On The Map
//
//  Created by Zach Eidenberger on 8/29/17.
//  Copyright © 2017 ZacharyG. All rights reserved.
//

import Foundation

class UdacityClient: NSObject {
    
    
    // MARK: Properties
    
    // shared session
    var session = URLSession.shared


    var udacityUserID: String = ""
    var udacitySessionID: String = ""
    var firstName: String = ""
    var lastName: String = ""
    
    
    
    // MARK: Initializers
    
    override init() {
        super.init()
    }
    
    
    // MARK: TODO - Create a taskForPostSession
    
    // used for logging in to Udacity
    func taskForPostSession (_ userName: String, _ password: String, completionHandlerforTaskForPostSession: (_ result: AnyObject?, _ error: NSError?)->Void) { // MARK: TODO; Determine the necessary parameters
        
    }
    
    
    // MARK: TODO - Create a taskForDeleteSession
    // used for logging out of udacity
    func taskForDeleteSession (completionHandlerForTaskForDeleteSession: (_ result: AnyObject?, _ error: NSError?)->Void) { // MARK: TODO; Determine the necessary parameters
        
    }
    
    // MARK: TODO - Create a taskForGetPublicUserData
    
    func taskForGetPublicUserData() { // MARK: TODO; Determine the necessary parameters
        
    }
    
    // MARK: Shared Instance
    
    class func sharedInstance() -> UdacityClient {
        struct Singleton {
            static var sharedInstance = UdacityClient()
        }
        return Singleton.sharedInstance
    }

}

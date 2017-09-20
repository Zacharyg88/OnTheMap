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
    // used for logging in to Udacity
    func taskForPostSession (_ userName: String, _ password: String, completionHandlerforTaskForPostSession: @escaping (_ result: AnyObject?, _ error: NSError?)->Void) {
        
        let request = NSMutableURLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"udacity\": {\"username\": \"\((userName) as String)\", \"password\": \"\((password) as String)\"}}".data(using: String.Encoding.utf8)
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            if error != nil {
                print("There was an Error at Login Data Request: \(error as Any)")
                return
            }
            let range = Range(5..<data!.count)
            let newData = data?.subdata(in: range)
            var parsedResults = [String:AnyObject]()
            do {
                parsedResults = try JSONSerialization.jsonObject(with: newData!, options: .allowFragments) as! [String:AnyObject]
            } catch {
                print("oops!")
                return
            }
            print(parsedResults)
            
            completionHandlerforTaskForPostSession(parsedResults as AnyObject?, error as NSError?)
            
            
        }
        task.resume()
    }
    
    // used for logging out of udacity
    
    func taskForDeleteSession (completionHandlerForTaskForDeleteSession: @escaping (_ result: AnyObject?, _ error: NSError?)->Void) {
        let request = NSMutableURLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil {
                return
            }
            let range = Range(5..<data!.count)
            let newData = data?.subdata(in: range)
            
            
            var parsedResult = [String: AnyObject]()
            
            do {
                parsedResult = try JSONSerialization.jsonObject(with: newData!, options: .allowFragments) as! [String: AnyObject]
            }catch {
                print("Couldn't Parse Delete Session Data")
                return
            }
            print(parsedResult)
            
            completionHandlerForTaskForDeleteSession(parsedResult as AnyObject, error as NSError?)
        }
        task.resume()
        
    }
    
    // used for getting user's public data
    
    func taskForGetPublicUserData(_ userID: String, completionHandlerFortaskForGetPublicUserData: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) {
        
        let request = NSMutableURLRequest(url: URL(string: "https://www.udacity.com/api/users/\(userID as String)")!)
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil {
                print("Get Public User Data Error = \(error)")
                return
            }
            let range = Range(5..<data!.count)
            let newData = data?.subdata(in: range)
            
            var parsedResults = [String: AnyObject]()
            do {
                parsedResults = try JSONSerialization.jsonObject(with: newData!, options: .allowFragments) as! [String: AnyObject]
            }catch {
                print("Couldn't Parse Public User Data JSON")
                return
            }
            print(parsedResults)
            
            completionHandlerFortaskForGetPublicUserData(parsedResults as AnyObject?, error as NSError?)
        }
        task.resume()
    }
    
    class func sharedInstance() -> UdacityClient {
        struct Singleton {
            static var sharedInstance = UdacityClient()
        }
        return Singleton.sharedInstance
    }
}

//
//  ParseClient.swift
//  On The Map
//
//  Created by Zach Eidenberger on 8/30/17.
//  Copyright © 2017 ZacharyG. All rights reserved.
//

import UIKit

class ParseClient: NSObject{
    
    func taskForGetStudentLocations(completionHandlerForGetStudentLocations: @escaping (_ results: AnyObject, _ error: NSError) -> Void) {
        let parseURL = URL(string: "https://parse.udacity.com/parse/classes/StudentLocation?limit=100")
        
        var request = NSMutableURLRequest(url:parseURL!)
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            if error != nil {
                print(error as Any)
                return
            }
            //print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue) as Any)
            
            var parsedResults = [String:Any]()
            var studentLocations = [[String:Any]]()
            do {
                parsedResults = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: Any]
            }catch {
                print("oops!")
                return
            }
            print("\nparsedResults: \(parsedResults)\n")
            
            studentLocations = parsedResults["results"] as! [[String : Any]]
            
            print("\nstudentLocations: \(studentLocations)\n")
            completionHandlerForGetStudentLocations(studentLocations as AnyObject, error as! NSError)
            
            // self.mapView?.animatesDrop = true
            }
        task.resume()

    }
    class func sharedInstance() -> ParseClient {
        struct Singleton {
            static var sharedInstance = ParseClient()
        }
        return Singleton.sharedInstance
    }



}

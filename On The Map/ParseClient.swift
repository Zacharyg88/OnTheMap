//
//  ParseClient.swift
//  On The Map
//
//  Created by Zach Eidenberger on 8/30/17.
//  Copyright © 2017 ZacharyG. All rights reserved.
//

import UIKit
import MapKit

class ParseClient: NSObject, MKMapViewDelegate{
    
    func taskForGetStudentLocations(completionHandlerForGetStudentLocations: @escaping (_ results: AnyObject, _ error: NSError?) -> Void) {
        let parseURL = URL(string: "https://parse.udacity.com/parse/classes/StudentLocation?limit=100")
        
        let request = NSMutableURLRequest(url:parseURL!)
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            if error != nil {
                print(error as Any)
                return
            }
            
            var parsedResults = [String:Any]()
            var studentLocations = [[String:Any]]()
            do {
                parsedResults = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: Any]
            }catch {
                print("oops!")
                return
            }
            
            studentLocations = parsedResults["results"] as! [[String : Any]]
                        
            completionHandlerForGetStudentLocations(studentLocations as AnyObject, error as NSError?)
        }
        task.resume()
    }
    
    func taskForPostStudentLocation(userInfo: [String: AnyObject], completionHandlerForPostStudentLocations: @escaping (_ results: AnyObject, _ error: NSError?)-> Void) {
        let parseURL = URL(string: "https://parse.udacity.com/parse/classes/StudentLocation")
        
        let request = NSMutableURLRequest(url: parseURL!)
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"uniqueKey\": \"1234\", \"firstName\": \"\(UdacityClient.udacityConstants.firstName)\", \"lastName\": \"\(UdacityClient.udacityConstants.lastName)\",\"mapString\": \"Mountain View, CA\", \"mediaURL\": \(UdacityClient.udacityConstants.mapString)\",\"latitude\": \(userInfo["latitude"]), \"longitude\": \(userInfo["longitude"])}".data(using: String.Encoding.utf8)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            if error != nil {
                completionHandlerForPostStudentLocations("" as AnyObject, error as NSError?)
            }else {
                completionHandlerForPostStudentLocations(data as AnyObject, nil)
            }
        }
        task.resume()
    }
    
    func taskForPutStudentLocation(userInfo: [String: AnyObject], completeionHandlerForPutStudentLocations: @escaping (_ results: AnyObject, _ error: NSError?)-> Void){
        
        let urlString = "https://parse.udacity.com/parse/classes/StudentLocation/8ZExGR5uX8"
        let url = URL(string: urlString)
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "PUT"
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"uniqueKey\": \"1234\", \"firstName\": \"\(UdacityClient.udacityConstants.firstName)\", \"lastName\": \"\(UdacityClient.udacityConstants.lastName)\",\"mapString\": \"Mountain View, CA\", \"mediaURL\": \(UdacityClient.udacityConstants.mapString)\",\"latitude\": \(userInfo["latitude"]), \"longitude\": \(userInfo["longitude"])}".data(using: String.Encoding.utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil {
                completeionHandlerForPutStudentLocations("" as AnyObject, error as? NSError)
                return
            } else {
                completeionHandlerForPutStudentLocations(data as AnyObject, nil)
            }
            
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

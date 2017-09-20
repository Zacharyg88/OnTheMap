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
    
    
    
    func taskForGetStudentLocations(completionHandlerForGetStudentLocations: @escaping (_ results: [studentInformation], _ error: NSError?) -> Void) {
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
            var studentInformationArray: [studentInformation] = []
            do {
                parsedResults = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: Any]
            }catch {
                print("oops!")
                return
            }
            
            guard parsedResults["results"] != nil else {
                print("parsed results returned nil")
                return
            }
            let results = parsedResults["results"] as! [[String: AnyObject]]
            for result in results {
                if result.count == 10 {
                    studentLocations.append(result)
                }
            }
            print(studentLocations)
            
            for student in studentLocations {
                let studentCase = studentInformation(firstName: student["firstName"] as! String, lastName: student["lastName"] as! String, mediaURL: student["mediaURL"] as! String, createdAt: student["createdAt"] as! String, updatedAt: student["updatedAt"] as! String, latitude: student["latitude"] as! Double, longitude: student["longitude"] as! Double, mapString: student["mapString"] as! String)
                
                studentInformationArray.append(studentCase)
            }
            print(studentInformationArray)
            
            completionHandlerForGetStudentLocations(studentInformationArray as [ParseClient.studentInformation], error as NSError?)
        }
        task.resume()
    }
    
    func taskForPostStudentLocation(userInfo: studentInformation, completionHandlerForPostStudentLocations: @escaping (_ results: AnyObject , _ error: NSError?)-> Void) {
        let parseURL = URL(string: "https://parse.udacity.com/parse/classes/StudentLocation")
        
        let request = NSMutableURLRequest(url: parseURL!)
        request.httpMethod = "POST"
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"uniqueKey\": \"\(UdacityClient.udacityConstants.userID)\", \"firstName\": \"\(userInfo.firstName)\", \"lastName\": \"\(userInfo.lastName)\",\"mapString\": \"\(userInfo.mapString)\", \"mediaURL\": \"\(userInfo.mediaURL)\",\"latitude\": \(userInfo.latitude), \"longitude\": \(userInfo.longitude)}".data(using: String.Encoding.utf8)
        
        request.timeoutInterval = 120
        let session = URLSession.shared
        var parsedData = [String: String]()
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            if error != nil {
                completionHandlerForPostStudentLocations("" as AnyObject, error as NSError?)
            }else {
                do {
                    parsedData = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String : String]
                }
                print(parsedData)
                
                completionHandlerForPostStudentLocations(parsedData as AnyObject, nil)
            }
        }
        task.resume()
    }
    
    func taskForPutStudentLocation(userInfo: studentInformation, completeionHandlerForPutStudentLocations: @escaping (_ results: AnyObject, _ error: NSError?)-> Void){
        
        print(userInfo)
        
        
        let urlString = "https://parse.udacity.com/parse/classes/StudentLocation/\(ParseClient.parseConstants.objectID)"
        let url = URL(string: urlString)
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "PUT"
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"uniqueKey\": \"\(UdacityClient.udacityConstants.userID)\", \"firstName\": \"\(userInfo.firstName)\", \"lastName\": \"\(userInfo.lastName)\",\"mapString\": \"\(userInfo.mapString)\", \"mediaURL\": \"\(userInfo.mediaURL)\",\"latitude\": \(userInfo.latitude), \"longitude\": \(userInfo.longitude)}".data(using: String.Encoding.utf8)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            var parsedData = [String: String]()
            print("The data is \(data)")
            print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!)
            
            do {
                parsedData = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String : String]
            }
            print(parsedData)
            
            if error != nil {
                completeionHandlerForPutStudentLocations("" as AnyObject, error as? NSError)
                return
            } else {
                completeionHandlerForPutStudentLocations(parsedData as AnyObject, nil)
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

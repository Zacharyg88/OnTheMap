//
//  ParseConvenience.swift
//  On The Map
//
//  Created by Zach Eidenberger on 8/30/17.
//  Copyright © 2017 ZacharyG. All rights reserved.
//

import UIKit

extension ParseClient  {
    
    func populateMap(convenienceMethodForHandlerForPopulateMap: @escaping (_ success: Bool, _ errorString: String) -> Void) {
        
        ParseClient.sharedInstance().taskForGetStudentLocations { (studentLocations, error) in
            
            if error != nil {
                convenienceMethodForHandlerForPopulateMap(false, "Couldn't Parse Student Location Data")
            }else{
                
                parseConstants.studentLocations = studentLocations 
                
            }
            convenienceMethodForHandlerForPopulateMap(true, "")
        }
        
    }

}

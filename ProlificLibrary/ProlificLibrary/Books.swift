//
//  Books.swift
//  ProlificLibrary
//
//  Created by KaL on 11/17/15.
//  Copyright © 2015 KaL. All rights reserved.
//

import Foundation
import Alamofire

class Books {
    
    private static let endpoint = "http://prolific-interview.herokuapp.com/5646360614807f000978562a/books/"
    
    static func get() {
        
        Alamofire.request(.GET, endpoint)
            .responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
        
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
        
    }
 
}



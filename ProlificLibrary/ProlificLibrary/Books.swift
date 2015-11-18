//
//  Books.swift
//  ProlificLibrary
//
//  Created by KaL on 11/17/15.
//  Copyright © 2015 KaL. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class Books {
    private static let endpoint = "http://prolific-interview.herokuapp.com/5646360614807f000978562a/books/"
    private static let dateFormatter: NSDateFormatter = NSDateFormatter()
    
    static func createDateFromString(dateString: String?) -> NSDate? {
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss:SSS"
        
        if let dateString = dateString {
             return dateFormatter.dateFromString(dateString) as NSDate?
        }
        
        return nil
    }
    
    // Example response from the server:
    //{
    //    author = "Erica Sadun";
    //    categories = ios;
    //    id = 5;
    //    lastCheckedOut = "<null>";
    //    lastCheckedOutBy = "<null>";
    //    publisher = "<null>";
    //    title = "The Core iOS 6 Developer's Cookbook";
    //    url = "/books/5/";
    //}
    static func get(callback: ([Book]) -> Void) {
        
        Alamofire.request(.GET, endpoint)
            .responseJSON { response in
        
            if let _ = response.result.value {
                let json = JSON(data: response.data!)
                
                // Basically do a map using a for loop
                var books = [Book]()
                
                for (_, value) in json {
                    books.append(Book(author: value["author"].string, bookTitle: value["bookTitle"].string, catogories: value["catogories"].string, id: value["id"].int!, lastCheckedOut: self.createDateFromString(value["lastCheckedOut"].string), lastCheckedOutBy: self.createDateFromString(value["lastCheckedOutBy"].string), publisher: value["publisher"].string, title: value["title"].string!, url: value["url"].string))
//                    print(books)

                }
                
                callback(books)
                
            }
        }
        
    }
 
}



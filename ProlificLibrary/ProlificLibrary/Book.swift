//
//  Book.swift
//  ProlificLibrary
//
//  Created by KaL on 11/18/15.
//  Copyright © 2015 KaL. All rights reserved.
//

//{
//    author = "Erica Sadun";
//    categories = ios;
//    id = 5;
//    lastCheckedOut = "<null>";
//    lastCheckedOutBy = "<null>";
//    publisher = "<null>";
//    title = "The Core iOS 6 Developer's Cookbook";
//    url = "/books/5/";
//},


import Foundation

class Book {
    
    var author: String?
    var bookTitle: String?
    var catogories: String?
    var id: Int?
    var lastCheckedOut: NSDate?
    var lastCheckedOutBy: NSDate?
    var publisher: String?
    var title: String?
    var url: String?
}

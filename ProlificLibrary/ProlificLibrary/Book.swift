//
//  Book.swift
//  ProlificLibrary
//
//  Created by KaL on 11/18/15.
//  Copyright © 2015 KaL. All rights reserved.
//

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
    
    init(author: String?, bookTitle: String?, catogories: String?, id: Int?, lastCheckedOut: NSDate?, lastCheckedOutBy: NSDate?, publisher: String?, title: String?, url: String?) {
        self.author = author
        self.bookTitle = bookTitle
        self.catogories = catogories
        self.id = id
        self.lastCheckedOut = lastCheckedOut
        self.lastCheckedOutBy = lastCheckedOutBy
        self.publisher = publisher
        self.title = title
        self.url = url
    }
}

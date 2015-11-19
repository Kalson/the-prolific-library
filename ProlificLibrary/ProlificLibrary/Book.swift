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
    var categories: String?
    var id: Int?
    var lastCheckedOut: NSDate?
    var lastCheckedOutBy: String?
    var publisher: String?
    var title: String?
    var url: String?
    
    init(author: String?, categories: String?, id: Int?, lastCheckedOut: NSDate?, lastCheckedOutBy: String?, publisher: String?, title: String?, url: String?) {
        self.author = author
        self.categories = categories
        self.id = id
        self.lastCheckedOut = lastCheckedOut
        self.lastCheckedOutBy = lastCheckedOutBy
        self.publisher = publisher
        self.title = title
        self.url = url
    }
}

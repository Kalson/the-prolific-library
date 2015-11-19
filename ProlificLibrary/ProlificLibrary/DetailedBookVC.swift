//
//  DetailedBookVC.swift
//  ProlificLibrary
//
//  Created by KaL on 11/15/15.
//  Copyright © 2015 KaL. All rights reserved.
//

import UIKit

class DetailedBookVC: UIViewController {
    
    var books = [Book]()

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var checkoutLabel: UILabel!
    @IBOutlet weak var checkoutButton: UIButton!
    
    var titleText: String!
    var authorText: String!
    var publisherText: String!
    var categoriesText: String!
    var checkoutText: String!


    @IBAction func checkoutButtonAction(sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = self.titleText
        authorLabel.text = self.authorText
        categoriesLabel.text = self.categoriesText
        
        if self.publisherText == nil {
            publisherLabel.text = "Publisher: No Publisher"
        } else {
            publisherLabel.text = "Publisher: \(self.publisherText)"
        }
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

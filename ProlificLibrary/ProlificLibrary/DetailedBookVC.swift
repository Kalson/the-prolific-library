//
//  DetailedBookVC.swift
//  ProlificLibrary
//
//  Created by KaL on 11/15/15.
//  Copyright © 2015 KaL. All rights reserved.
//

import UIKit
import SAMGradientView

class DetailedBookVC: UIViewController {
    
    var book: Book!
    let dateFormatter = NSDateFormatter()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var lastCheckOutLabel: UILabel!
    @IBOutlet weak var checkoutButton: UIButton!
    @IBOutlet weak var checkoutBookLabel: UILabel!
    @IBOutlet weak var lastCheckoutByLabel: UILabel!
    
    @IBAction func checkoutButtonAction(sender: AnyObject) {
        
        let alertController = UIAlertController(title: "Check Out", message: "Do you want to check out \(book.title!)", preferredStyle: .Alert)
        let checkoutAction = UIAlertAction(title: "Check out", style: .Default) { (action: UIAlertAction) -> Void in
            let textField = alertController.textFields!.first
            self.saveCheckOutName(textField!.text!)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Destructive, handler: nil)
        alertController.addAction(checkoutAction)
        alertController.addAction(cancelAction)
        
        alertController.addTextFieldWithConfigurationHandler({ (textfield: UITextField) -> Void in
            
        })
        
        self.presentViewController(alertController, animated: true, completion: nil)

    }
    
    @IBAction func shareButtonAction(sender: AnyObject) {
        let shareString = "Check out this book I just got '\(titleLabel.text!)' using the Prolific Library App"
        let itemsToShare = [shareString]
        let activityVC = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
        self.presentViewController(activityVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateStyle = .LongStyle
        dateFormatter.timeStyle = .ShortStyle
        
        setupStyles()
        
        titleLabel.text = book.title
        authorLabel.text = book.author
        categoriesLabel.text = book.categories
        
        if let publisher = book.publisher {
            publisherLabel.text = "Publisher: \(publisher)"
        }
        
        if let lastCheckedOutBy = book.lastCheckedOutBy {
            // Format: June 3, 2013 1:45pm
            lastCheckoutByLabel.text = "\(lastCheckedOutBy) @ \(dateFormatter.stringFromDate(book.lastCheckedOut!))"
            
        }
//        if let lastCheckout = book.lastCheckedOutBy {
//            lastCheckoutByLabel.text = lastCheckout
//        } 
        
//        if let dateCheckout = dateFormatter.stringFromDate(book.lastCheckedOut!) {
//          lastCheckoutByLabel.text = dateCheckout
//        }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveCheckOutName(name: String) {
        book.lastCheckedOutBy = name
        book.lastCheckedOut = NSDate()
        Books.update(book)
        
        print("sgshshjrh")
        print("+++++ \(lastCheckoutByLabel.text)")
    }
    
    func setupStyles() {
        // create gradient View
        let gradientView = SAMGradientView(frame: CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height))
        gradientView.gradientColors = [UIColor(red: 0.1608, green: 0.6235, blue: 0.7804, alpha: 1.0), UIColor(red: 0.1059, green: 0.7804, blue: 0.6, alpha: 1.0)]
        self.view.insertSubview(gradientView, atIndex: 0)
        
        // set the checkout button attributes
        self.checkoutButton.backgroundColor = UIColor(white: 1.0, alpha: 0.3)
        self.checkoutButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.checkoutButton.layer.cornerRadius = 5
        
        self.checkoutBookLabel.textColor = UIColor(white: 1.0, alpha: 0.65)
        
        // set color of textlabels and textView
        self.titleLabel.textColor = UIColor.whiteColor()
        self.authorLabel.textColor = UIColor.whiteColor()
        self.publisherLabel.textColor = UIColor.whiteColor()
        self.categoriesLabel.textColor = UIColor.whiteColor()
        self.lastCheckOutLabel.textColor = UIColor.whiteColor()
        self.lastCheckoutByLabel.textColor = UIColor.whiteColor()

    }

}

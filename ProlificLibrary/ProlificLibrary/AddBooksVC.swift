//
//  AddBooksVC.swift
//  ProlificLibrary
//
//  Created by KaL on 11/15/15.
//  Copyright © 2015 KaL. All rights reserved.
//

import UIKit
import SAMGradientView

class AddBooksVC: UIViewController {
    
    
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var publisherTextField: UITextField!
    @IBOutlet weak var categoriesTextField: UITextField!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var bookLabel: UILabel!
    
    
    @IBAction func cancelButtonAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func doneButtonAction(sender: AnyObject) {
        if self.bookTitleTextField.text == "" || self.authorTextField.text == "" || self.publisherTextField.text == "" || self.categoriesTextField.text == "" {
            let alert = UIAlertController(title: "Error", message: "You left a field blank", preferredStyle: .Alert)
            let okayAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(okayAction)
            self.presentViewController(alert, animated: true, completion: nil)
            
        } else {
            // post request
            let book = Book(author: self.authorTextField.text, categories: self.categoriesTextField.text, id: nil, lastCheckedOut: nil, lastCheckedOutBy: nil, publisher: self.publisherTextField.text, title: self.bookTitleTextField.text, url: nil)
            Books.post(book, completionHandler: { (response) -> Void in
                self.dismissViewControllerAnimated(true, completion: nil)
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create gradient view
        let gradientView = SAMGradientView(frame: CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height))
        gradientView.gradientColors = [UIColor(red: 0.1608, green: 0.6235, blue: 0.7804, alpha: 1.0), UIColor(red: 0.1059, green: 0.7804, blue: 0.6, alpha: 1.0)]
        self.view.addSubview(gradientView)
        
        self.bookLabel.textColor = UIColor(white: 1.0, alpha: 0.65)
        
        // add textfields & booklabel to gradient view
        gradientView.addSubview(bookTitleTextField)
        gradientView.addSubview(authorTextField)
        gradientView.addSubview(publisherTextField)
        gradientView.addSubview(categoriesTextField)
        gradientView.addSubview(bookLabel)
        
        // set textfields
        self.bookTitleTextField.backgroundColor = UIColor.clearColor()
        self.bookTitleTextField.tintColor = UIColor.whiteColor()
        let bookTitleStr = NSAttributedString(string: "Book Title", attributes: [NSForegroundColorAttributeName:UIColor.whiteColor()])
        self.bookTitleTextField.attributedPlaceholder = bookTitleStr
        
        self.authorTextField.backgroundColor = UIColor.clearColor()
        self.authorTextField.tintColor = UIColor.whiteColor()
        let authorStr = NSAttributedString(string: "Author", attributes: [NSForegroundColorAttributeName:UIColor.whiteColor()])
        self.authorTextField.attributedPlaceholder = authorStr
        
        self.publisherTextField.backgroundColor = UIColor.clearColor()
        self.publisherTextField.tintColor = UIColor.whiteColor()
        let publisherStr = NSAttributedString(string: "Publisher", attributes: [NSForegroundColorAttributeName:UIColor.whiteColor()])
        self.publisherTextField.attributedPlaceholder = publisherStr
        
        self.categoriesTextField.backgroundColor = UIColor.clearColor()
        self.categoriesTextField.tintColor = UIColor.whiteColor()
        let categoriesStr = NSAttributedString(string: "Categories", attributes: [NSForegroundColorAttributeName:UIColor.whiteColor()])
        self.categoriesTextField.attributedPlaceholder = categoriesStr
        
        // set the textfields as delegates of the UItextfield protocols
        self.bookTitleTextField.delegate = self
        self.authorTextField.delegate = self
        self.publisherTextField.delegate = self
        self.categoriesTextField.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension AddBooksVC: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

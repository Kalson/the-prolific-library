//
//  AddBooksVC.swift
//  ProlificLibrary
//
//  Created by KaL on 11/15/15.
//  Copyright © 2015 KaL. All rights reserved.
//

import UIKit

class AddBooksVC: UIViewController {
    
    
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var publisherTextField: UITextField!
    @IBOutlet weak var categoriesTextField: UITextField!
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var submitButton: UIButton!
    
    @IBAction func doneButtonAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func submitButtonAction(sender: AnyObject) {
        
        if self.bookTitleTextField.text == "" || self.authorTextField.text == "" || self.publisherTextField.text == "" || self.categoriesTextField.text == "" {
            let alert = UIAlertController(title: "Error", message: "You left a field blank", preferredStyle: .Alert)
            let okayAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(okayAction)
            self.presentViewController(alert, animated: true, completion: nil)
            
        } else {
            // post request
            let book = Book(author: self.authorTextField.text, categories: self.categoriesTextField.text, id: nil, lastCheckedOut: nil, lastCheckedOutBy: nil, publisher: self.publisherTextField.text, title: self.bookTitleTextField.text, url: nil)
           Books.post(book)
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bookTitleTextField.becomeFirstResponder()
        
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

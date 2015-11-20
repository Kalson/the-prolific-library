//
//  TableViewController.swift
//  ProlificLibrary
//
//  Created by KaL on 11/15/15.
//  Copyright © 2015 KaL. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var books = [Book]()
    var refreshData = UIRefreshControl()
    
    @IBOutlet weak var trashButton: UIBarButtonItem!
    @IBAction func trashButtonAction(sender: AnyObject) {
        let alertController = UIAlertController(title: "Delete All?", message: "Are you sure you want to delete all books?", preferredStyle: .Alert)
        let deleteAction = UIAlertAction(title: "Delete", style: .Destructive) { (action: UIAlertAction) -> Void in
            Books.deleteAll(self.books)
            
//            dispatch_async(dispatch_get_main_queue()) { () -> Void in
//                self.tableView.reloadData()
//
//            }
            
        
            print("DELETE")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        self.presentViewController(alertController, animated: true, completion: nil)

        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self presentViewController:AlertView animated:YES completion:nil];
//            });
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create refresh
        self.refreshData.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshData.addTarget(self, action: Selector("refresh"), forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(self.refreshData)
        
    }
    
    func refresh(){
        Books.get { (books: [Book]) -> Void in
            self.books = books
            self.tableView.reloadData()
            
            print("Books items:\(books) at a total of \(books.count)")
        }
        
        if self.refreshData.refreshing {
            self.refreshData.endRefreshing()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        
        print("VIEWWILLAPPEAR")
        refresh()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.books.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)

        // Configure the cell...
        if let title = books[indexPath.row].title {
            cell.textLabel?.text = title
        } else {
            cell.textLabel?.text = "Untitled"

        }
        
        if let author = books[indexPath.row].author {
            cell.detailTextLabel?.text = author
        } else {
            cell.textLabel?.text = "No author"

        }

        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showBookDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let destinationController = segue.destinationViewController as! DetailedBookVC
                destinationController.titleText = self.books[indexPath.row].title
                destinationController.authorText = self.books[indexPath.row].author
                destinationController.publisherText = self.books[indexPath.row].publisher
                destinationController.categoriesText = self.books[indexPath.row].categories
                
                print("Last checkout by = \(self.books[indexPath.row].lastCheckedOutBy)")
            }
            
        }
    }
  
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            // delete Book
            Books.delete(books[indexPath.row])
            books.removeAtIndex(indexPath.row)
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            tableView.reloadData()
           
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

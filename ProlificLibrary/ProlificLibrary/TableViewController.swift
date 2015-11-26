//
//  TableViewController.swift
//  ProlificLibrary
//
//  Created by KaL on 11/15/15.
//  Copyright © 2015 KaL. All rights reserved.
//

import UIKit
import SAMGradientView

class TableViewController: UITableViewController {
    
    var books = [Book]()
    var refreshData = UIRefreshControl()
    
    @IBOutlet weak var trashButton: UIBarButtonItem!
    @IBAction func trashButtonAction(sender: AnyObject) {
        let alertController = UIAlertController(title: "Delete All?", message: "Are you sure you want to delete all books?", preferredStyle: .Alert)
        let deleteAction = UIAlertAction(title: "Delete", style: .Destructive) { (action: UIAlertAction) -> Void in
            
            Books.deleteAll(self.books) { (response) in
                self.refresh()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        
        alertController.view.backgroundColor = UIColor.clearColor()
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.clearColor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create gradient View
        let gradientView = SAMGradientView()
        gradientView.gradientColors = [UIColor(red: 0.1608, green: 0.6235, blue: 0.7804, alpha: 1.0), UIColor(red: 0.1059, green: 0.7804, blue: 0.6, alpha: 1.0)]
        self.tableView.backgroundView = gradientView
    
        self.tableView.separatorColor = UIColor(white: 1.0, alpha: 0.3)
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        self.tableView.rowHeight = 60

        // create refresh
        let attributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        let attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: attributes)
        self.refreshData.attributedTitle = attributedTitle
        self.refreshData.tintColor = UIColor(white: 1.0, alpha: 0.5)
        self.refreshData.addTarget(self, action: Selector("refresh"), forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(self.refreshData)
    
    }
    
    func refresh(){
        Books.get { (books) -> Void in
            self.books = books
            self.tableView.reloadData()
            
            print("Books items:\(books) at a total of \(books.count)")
            
        }
        
        if self.refreshData.refreshing {
            self.refreshData.endRefreshing()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
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
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.detailTextLabel?.textColor = UIColor.whiteColor()
        cell.layoutMargins = UIEdgeInsetsZero
        cell.preservesSuperviewLayoutMargins = false

        cell.textLabel?.font = UIFont(name: cell.textLabel!.font!.fontName, size: 18)
        
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
                destinationController.book = books[indexPath.row]
                
                print("Last checkout by = \(self.books[indexPath.row].lastCheckedOutBy)")
                print("Last checkout date = \(self.books[indexPath.row].lastCheckedOut)")
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
        

}

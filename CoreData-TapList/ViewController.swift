//
//  ViewController.swift
//  CoreData-TapList
//
//  Created by zklgame on 6/29/16.
//  Copyright © 2016 Zhejiang University. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var context: NSManagedObjectContext = {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return appDelegate.managedObjectContext
    }()
    
    var tableData: [Item]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = CGFloat(76)
        self.tableView.rowHeight = CGFloat(76)
        
        self.updateTableView()
    }
    
    @IBAction func addItem() {
        let alert = UIAlertController(title: "Add Item", message: nil, preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Save", style: .Default) { (action) in
            let nameField = alert.textFields![0]
            let scoreField = alert.textFields![1]
            
            let item = NSEntityDescription.insertNewObjectForEntityForName("Item", inManagedObjectContext: self.context) as! Item
            item.name = nameField.text
            item.score = Int(scoreField.text!) ?? 0
            item.image = UIImage(named: "meow")
            
            do {
                try self.context.save()
                self.updateTableView()
            } catch let error as NSError {
                print("Error: \(error.userInfo)")
            }
        }
        
        alert.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "name"
        }
        alert.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "score"
        }
        
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func updateTableView() {
        let fetchRequest = NSFetchRequest(entityName: "Item")
        let sortDescriptor = NSSortDescriptor(key: "score", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            tableData = try self.context.executeFetchRequest(fetchRequest) as! [Item]
            self.tableView.reloadData()
        } catch let error as NSError {
            print("ERROR: \(error.userInfo)")
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: indexPath) as! ItemCell
        
        cell.item = self.tableData[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let item = self.tableData[indexPath.row]
        let score = item.score!.integerValue
        item.score = NSNumber(integer: score + 1)
        
        do {
            try self.context.save()
            self.updateTableView()
        } catch let error as NSError {
            print("Error: \(error.userInfo)")
        }
    }
    
}







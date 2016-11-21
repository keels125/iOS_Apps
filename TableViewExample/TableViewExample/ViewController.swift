//
//  ViewController.swift
//  TableViewExample
//
//  Created by Keely Hicks on 11/7/16.
//  Copyright © 2016 Keely Hicks. All rights reserved.
//  Tutorial taken from StackOverlow and We ❤ Swift

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var itemDesc: UITextField!
    @IBOutlet weak var addItem: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var animal = [NSManagedObject]()
    
    let cellReuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        //Register table view cell class
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        addItem.addTarget(self, action: "buttonPress:", forControlEvents: UIControlEvents.TouchDown)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animal.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        let a = animal[indexPath.row]
        
        cell!.textLabel!.text = a.valueForKey("name") as? String
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            animal.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade
            )
        } else if editingStyle == .Insert {
            print("here")
            
        }
        
    }
    
    func buttonPress(sender: UIButton) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let entity =  NSEntityDescription.entityForName("A",
            inManagedObjectContext:managedContext)
        
        let a = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext: managedContext)
        
        a.setValue(itemDesc.text!, forKey: "name")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
        
        
        
        
        
        /*animals.append(itemDesc.text!)
        tableView.beginUpdates()
        tableView.insertRowsAtIndexPaths([
            NSIndexPath(forRow: animals.count-1, inSection: 0)
            ], withRowAnimation: .Automatic)
        tableView.endUpdates()
        */
        
    }
   


}


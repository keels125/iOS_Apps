//
//  SecondViewController.swift
//  MigraineTracker
//
//  Created by Keely Hicks on 9/6/16.
//  Copyright © 2016 Keely Hicks. All rights reserved.
//

import UIKit
import CoreData

class SecondViewController: UIViewController, UITableViewDataSource {

    @IBAction func addMigraine(sender: AnyObject) {
        
        let alert = UIAlertController(title: "New Migraine", message: "Add a description", preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save",
            style: .Default,
            handler: { (action:UIAlertAction) -> Void in
                
                let textField = alert.textFields!.first
                self.saveName(textField!.text!)
                self.migrainesList.reloadData()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel",
            style: .Default) { (action: UIAlertAction) -> Void in
        }
        
        alert.addTextFieldWithConfigurationHandler {
            (textField: UITextField) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert,
            animated: true,
            completion: nil)
        
    }
    @IBOutlet weak var migrainesList: UITableView!
    
    var migraines = [NSManagedObject]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\"Migraines\""
        migrainesList.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return migraines.count
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {
            
            let cell =
            tableView.dequeueReusableCellWithIdentifier("Cell")
            
            let person = migraines[indexPath.row]
            
            cell!.textLabel!.text =
                person.valueForKey("desc") as? String
            
            return cell!
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            migraines.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade
            )
        }
        
    }
    
    func saveName(name: String) {
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let entity =  NSEntityDescription.entityForName("Migraine",
            inManagedObjectContext:managedContext)
        
        let person = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext: managedContext)
        
        //3
        person.setValue(name, forKey: "desc")
        
        //4
        do {
            try managedContext.save()
            //5
            migraines.append(person)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let fetchRequest = NSFetchRequest(entityName: "Migraine")
        
        //3
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            migraines = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }

    


}


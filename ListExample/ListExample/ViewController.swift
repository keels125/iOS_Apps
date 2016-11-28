//
//  ViewController.swift
//  ListExample
//
//  Created by Keely Hicks on 11/28/16.
//  Copyright © 2016 Keely Hicks. All rights reserved.
//  Tutorial taken from Ray Wenderlich: https://www.raywenderlich.com/115695/getting-started-with-core-data-tutorial

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var names = [String]()
    
    @IBAction func addName(sender: AnyObject) {
        
        let alert = UIAlertController(title: "New Name", message: "Add a new name", preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save",
            style: .Default,
            handler: { (action:UIAlertAction) -> Void in
                
                let textField = alert.textFields!.first
                self.names.append(textField!.text!)
                self.tableView.reloadData()
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


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\"List\""
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    /*func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            //table view # of rows = # of elements in names array
            return names.count
    }*/
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {
            
            //dequeues cells from the table view and adds them to names array
            
            let cell =
            tableView.dequeueReusableCellWithIdentifier("Cell")
            
            cell!.textLabel!.text = names[indexPath.row]
            
            return cell!
    }
    


}


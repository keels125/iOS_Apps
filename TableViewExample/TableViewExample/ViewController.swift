//
//  ViewController.swift
//  TableViewExample
//
//  Created by Keely Hicks on 11/7/16.
//  Copyright © 2016 Keely Hicks. All rights reserved.
//  Tutorial taken from StackOverlow and We ❤ Swift

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var itemDesc: UITextField!
    @IBOutlet weak var addItem: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var animals: [String] = ["Horse", "Cow", "Camel", "Sheep", "Goat"]
    let cellReuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Register table view cell class
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        addItem.addTarget(self, action: "buttonPress:", forControlEvents: UIControlEvents.TouchDown)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.animals.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier) as UITableViewCell!
        cell.textLabel?.text = self.animals[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            animals.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade
            )
        } else if editingStyle == .Insert {
            print("here")
            
        }
        
    }
    
    func buttonPress(sender: UIButton) {
        animals.append(itemDesc.text!)
        tableView.beginUpdates()
        tableView.insertRowsAtIndexPaths([
            NSIndexPath(forRow: animals.count-1, inSection: 0)
            ], withRowAnimation: .Automatic)
        tableView.endUpdates()
        
    }
   


}


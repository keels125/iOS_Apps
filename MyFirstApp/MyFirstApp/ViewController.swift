//
//  ViewController.swift
//  MyFirstApp
//
//  Created by Keely Hicks on 8/31/16.
//  Copyright © 2016 Keely Hicks. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var yField: UITextField!
    @IBOutlet weak var xField: UITextField!
    @IBOutlet weak var calculateButton: UIButton!
    
    @IBOutlet weak var resultField: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calculateButton.addTarget(self, action: "buttonPress:", forControlEvents: UIControlEvents.TouchDown)
        
    }
    
    func buttonPress(sender: UIButton) {
        let x = xField.text!
        let y = yField.text!
        
        if Int(x) != nil && Int(y) != nil{
            resultField.text! += String(Int(x)! + Int(y)!)
        }
    }

}


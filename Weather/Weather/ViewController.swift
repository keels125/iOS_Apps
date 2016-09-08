//
//  ViewController.swift
//  Weather
//
//  Created by Keely Hicks on 9/6/16.
//  Copyright © 2016 Keely Hicks. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var getWeatherButton: UIButton!
    @IBOutlet weak var weatherDesc: UILabel!
    
    let locationManager = CLLocationManager() //used for getting current coords
    
    
    var lat = 0
    var long = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestAlwaysAuthorization() //request auth from user
        self.locationManager.requestWhenInUseAuthorization() //app in foreground
        
        if CLLocationManager.locationServicesEnabled() {
        
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        lat =  Int(locValue.latitude) //Trim for API use
        long = Int(locValue.longitude)
    
    }
    
    /*func getWeather() {
        var urlPath = "api.openweathermap.org/data/2.5/weather?lat=" + String(lat) + "&lon=" +
        String(long)+"&units=imperial&appid=3a762d1a0b2e642dcf94080d1d6f0fbb"
        
        let url = NSURL(string: urlPath)
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
            print("Task completed")
            if(error != nil) {
                // If there is an error in the web request, print it to the console
                print(error!.localizedDescription)
            }
            var err: NSError?
            if let jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
                if(err != nil) {
                    // If there is an error parsing JSON, print it to the console
                    print("JSON Error \(err!.localizedDescription)")
                }
                if let results: NSArray = jsonResult["results"] as? NSArray {
                    dispatch_async(dispatch_get_main_queue(), {
                                            })
                }
            }
        })
        
        // The task is just an object with all these properties set
        // In order to actually make the web request, we need to "resume"
        task.resume()
    }*/
}





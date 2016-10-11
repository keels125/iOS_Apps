//
//  FirstViewController.swift
//  MigraineTracker
//
//  Created by Keely Hicks on 9/6/16.
//  Copyright © 2016 Keely Hicks. All rights reserved.
//

import UIKit
import UIKit
import MapKit
import CoreLocation

class FirstViewController: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var getWeatherButton: UIButton!
    @IBOutlet weak var weatherDesc: UITextView!

    let locationManager = CLLocationManager() //used for getting current coords
    
    var lat = 0
    var long = 0
    
    var temp = ""
    var pressure = ""
    var humidity = ""
    var min_temp = ""
    var max_temp = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestAlwaysAuthorization() //request auth from user
        self.locationManager.requestWhenInUseAuthorization() //app in foreground
        
        if CLLocationManager.locationServicesEnabled() {
            
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()
        }
        
        getWeatherButton.addTarget(self, action: "buttonPress:", forControlEvents: UIControlEvents.TouchDown)
        
        
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        locationManager.stopUpdatingLocation()
        
        //let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        let locValue: CLLocation = locations[locations.count - 1]
        
        self.lat =  Int(locValue.coordinate.latitude) //Trim for API use
        self.long = Int(locValue.coordinate.longitude)
        
    }
    
    func getWeather() {
        
        let urlPath = "http://api.openweathermap.org/data/2.5/weather?lat=" + String(self.lat) + "&lon=" +
            String(self.long)+"&units=imperial&appid=3a762d1a0b2e642dcf94080d1d6f0fbb"
        
        print(self.lat, self.long)
        
        let url = NSURL(string: urlPath)
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
            print("Task completed")
            if(error != nil) {
                // If there is an error in the web request, print it to the console
                print(error!.localizedDescription)
            }
            var err: NSError?
            do {
                if let jsonResult:[String:AnyObject] = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? [String:AnyObject] {
                    if(err != nil) {
                        // If there is an error parsing JSON, print it to the console
                        print("JSON Error \(err!.localizedDescription)")
                    }
                    if let results = jsonResult["main"] as? [String: AnyObject]
                    {
                        dispatch_async(dispatch_get_main_queue(), {
                        })
                        
                        
                        self.temp = String(results["temp"]!)
                        
                        self.pressure = String(results["pressure"]!)
                        self.humidity = String(results["humidity"]!)
                        self.min_temp = String(results["temp_min"]!)
                        self.max_temp = String(results["temp_max"]!)
                        
                        
                        
                    }
                    //self.weatherDesc.text = results["pressure"]
                }
                
            } catch let error as NSError {
                print("json error \(error.localizedDescription)")
            }
            
        })
        
        // The task is just an object with all these properties set
        // In order to actually make the web request, we need to "resume"
        task.resume()
        
    }
    
    
    func buttonPress(sender: UIButton) {
        self.locationManager.startUpdatingLocation()
        getWeather()
        while (self.max_temp=="") {
            //wait
        }
        
        self.weatherDesc.text  = "Current temperature: "+self.temp+"\n"+"Pressure: "+self.pressure+"\n"+"Humidity: "+self.humidity+"%\n"+"Min temp: "+self.min_temp+"\n"+"Max temp: "+self.max_temp
        
    }

    


}


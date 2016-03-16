//  Location.swift
//  LocTracker
//
//  Created by Mac on 3/10/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import UIKit
import CoreLocation

class Location: NSObject, CLLocationManagerDelegate {
    
    var locmanager = CLLocationManager()
    var currentLocation = CLLocation()
    var region: CLRegion!
    var checkInTime: String!
    var checkInDate: String!
    var checkOutTime: String!
    var checkOutDate: String!
    var time1: Double!
    var time2: Double!
    var address: String!
    
    let userDefault = NSUserDefaults.standardUserDefaults()
    
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .NotDetermined {
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
        }
    }
    
    override init() {
        super.init()
        
        locmanager.delegate = self
        locmanager.requestWhenInUseAuthorization()
        locmanager.startUpdatingLocation()
        locmanager.desiredAccuracy = kCLLocationAccuracyBest
        
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let loc = (locations as NSArray).lastObject
        currentLocation =  loc as! CLLocation
//        let geoCoder = CLGeocoder()
//        
//        geoCoder.reverseGeocodeLocation(currentLocation, completionHandler: { (data, error) -> Void in
//            let placeMarks = data! as [CLPlacemark]
//            let location: CLPlacemark = placeMarks[0]
//            
//            let addr = location.locality
//            self.address = addr
//            
//        })
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        
        locmanager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didStartMonitoringForRegion region: CLRegion) {
        print("You are now monitoring for \(region.identifier)")
    }
    
    
    
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        
        print("Enter Region")
        
        let checkIndateAndTime = getCurrentDateAndTime()
        checkInTime = checkIndateAndTime.0[0]
        checkInDate = checkIndateAndTime.0[1]
        time1 = checkIndateAndTime.1
        print(time1)
        userDefault.setDouble(time1, forKey: "time1")
        
        
    }
    
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        
        let checkOutdateAndTime = getCurrentDateAndTime()
        checkOutTime = checkOutdateAndTime.0[0]
        checkOutDate = checkOutdateAndTime.0[1]
        time2 = checkOutdateAndTime.1
        userDefault.setDouble(time2, forKey: "time2")
        
        print("Exit Region")
    }
    
    
    func getCurrentDateAndTime() -> (Array<String>, Double)  {
        
        let timeStamp = NSDate().timeIntervalSince1970
        
        let dateAndTimeFormatter = NSDateFormatter()
        dateAndTimeFormatter.timeStyle = .ShortStyle
        dateAndTimeFormatter.dateStyle = .ShortStyle
        
        let currentDateAndTime = NSDate(timeIntervalSince1970: timeStamp)
        let formatDateAndTime = dateAndTimeFormatter.stringFromDate(currentDateAndTime)
        
        let dateAndTime = formatDateAndTime.componentsSeparatedByString(", ")
        
        return (dateAndTime,timeStamp)
        
    }
    
}

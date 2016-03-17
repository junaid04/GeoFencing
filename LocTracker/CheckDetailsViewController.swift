//
//  CheckDetailsViewController.swift
//  LocTracker
//
//  Created by Mac on 3/15/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import UIKit

class CheckDetailsViewController: UIViewController {
    
    let location = Location()
    

    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    var timeVal: String!
    var dateVal: String!
    var dateVal2: String!
    var timeVal2: String!
    var timDiff: String!
    let userDefault = NSUserDefaults.standardUserDefaults()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    func formatDate(timeStamp: Double) -> String  {
        
        let dateAndTimeFormatter = NSDateFormatter()
        dateAndTimeFormatter.timeStyle = .ShortStyle
        dateAndTimeFormatter.dateStyle = .ShortStyle
        
        let currentDateAndTime = NSDate(timeIntervalSince1970: timeStamp)
        let formatDateAndTime = dateAndTimeFormatter.stringFromDate(currentDateAndTime)
        
        return formatDateAndTime
        

    }
    
    override func viewWillAppear(animated: Bool) {
        
        timeVal = location.checkInTime
        dateVal = location.checkInDate
        
        timeVal2 = location.checkOutTime
        dateVal2 = location.checkOutDate
        
        let time1 = userDefault.valueForKey("time1") as! Double
        let time2 = userDefault.valueForKey("time2") as! Double
        
        let timeDiff = time2 - time1
         let hours = timeDiff/3600
        let minutes = Int((timeDiff % 3600) / 60)
        print("\(hours)" + "\( minutes)")
        
       let ftime1 = formatDate(time1)
       let ftime2 =  formatDate(time2)
        
        
        
        
        lblTime.text = "Check in at \(ftime1) "
        lblDate.text = "Check out at \(ftime2)"
        
    }

    
    
   
}
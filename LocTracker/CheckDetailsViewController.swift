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
    
    override func viewWillAppear(animated: Bool) {
        
        timeVal = location.checkInTime
        dateVal = location.checkInDate
        
        timeVal2 = location.checkOutTime
        dateVal2 = location.checkOutDate
        
        let time1 = userDefault.valueForKey("time1") as! Double
        let time2 = userDefault.valueForKey("time2") as! Double
        
        let timeDiff = time2 - time1
        print(timeDiff)
        let time = NSDate(timeIntervalSince1970: timeDiff)
        let df = NSDateFormatter()
        df.dateStyle = .NoStyle
        df.timeStyle = .ShortStyle
        
        let formTime = df.stringFromDate(time)
        print(formTime)
        
        
        lblTime.text = "Check in at \(timeVal) \(dateVal)"
        lblDate.text = "Check out at \(timeVal2) \(dateVal2)"
    }

    
    
   
}

extension CheckDetailsViewController : UITableViewDelegate, UITableViewDataSource{





}

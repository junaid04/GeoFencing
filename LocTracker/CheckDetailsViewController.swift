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
    let userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    func formatDate(_ timeStamp: Double) -> String  {
        
        let dateAndTimeFormatter = DateFormatter()
        dateAndTimeFormatter.timeStyle = .short
        dateAndTimeFormatter.dateStyle = .short
        
        let currentDateAndTime = Date(timeIntervalSince1970: timeStamp)
        let formatDateAndTime = dateAndTimeFormatter.string(from: currentDateAndTime)
        
        return formatDateAndTime
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        timeVal = location.checkInTime
        dateVal = location.checkInDate
        
        timeVal2 = location.checkOutTime
        dateVal2 = location.checkOutDate
        
        var time1:Double = 0.0
        var time2:Double = 0.0
        
        if let t1 = userDefault.value(forKey: "time1") as? Double {
            time1 = t1
        }
        
        if let t2 = userDefault.value(forKey: "time2") as? Double {
            time2 = t2
        }
        
        if time1 != 0.0 && time2 != 0.0 {
            let timeDiff = time2 - time1
            let hours = timeDiff/3600
            let minutes = Int((timeDiff.truncatingRemainder(dividingBy: 3600)) / 60)
            print("\(hours)" + "\( minutes)")
            
            let ftime1 = formatDate(time1)
            let ftime2 =  formatDate(time2)
            
            lblTime.text = "Check in at \(ftime1) "
            lblDate.text = "Check out at \(ftime2)"
        }
    }
}

//
//  mapClass.swift
//  LocTracker
//
//  Created by Mac on 3/10/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import UIKit
import MapKit

class mapClass: NSObject, MKMapViewDelegate {

    var coordinate : CLLocationCoordinate2D
    var title : String
    
    init(title : String,coordinate : CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }

      
}

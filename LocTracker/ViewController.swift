//
//  ViewController.swift
//  LocTracker
//
//  Created by Mac on 3/10/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate{
    
    //Variables
    var loc = Location()
    var circle:MKCircle!
    var circleRenderer : MKCircleRenderer!
    var region: MKCoordinateRegion!
    
    
    //Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        mapView.delegate = self
        mapView.showsUserLocation = true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        makeRegion()
        loadOverlayForRegionWithLatitude(region.center.latitude, andLongitude: region.center.longitude)
    }
    
    
    //MARK: - Map view delegate
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        
        self.mapView.showsUserLocation = true
        let userLocation = mapView.userLocation
        mapView.centerCoordinate = userLocation.coordinate
        
        let dropPin = MKPointAnnotation()
        dropPin.coordinate = region.center
        dropPin.title = "Add"
        mapView.addAnnotation(dropPin)
        
        
    }
    
    //render visual circle on map
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        circleRenderer = MKCircleRenderer(overlay: overlay)
        circleRenderer.fillColor = UIColor.red.withAlphaComponent(0.1)
        circleRenderer.strokeColor = UIColor.red
        circleRenderer.lineWidth = 1
        return circleRenderer
        
    }
    
    //MARK: - Actions
    //zoom into current Location
    @IBAction func zoomIntoLocation(_ sender: AnyObject) {
        
        let userLocation = mapView.userLocation
        if userLocation.location?.coordinate != nil {
            let region = MKCoordinateRegionMakeWithDistance(
                userLocation.location!.coordinate, 2000, 2000)
            mapView.setRegion(region, animated: true)
        }
    }
    
    //Region Monitor
    @IBAction func monitorRegion(_ sender: AnyObject) {
        
        loc.locmanager.requestAlwaysAuthorization()
        let centre = region.center
        let circularRegion = CLCircularRegion(center: centre, radius: 200, identifier: "Work")
        loc.locmanager.startMonitoring(for: circularRegion)
    }
    
    // MARK: - Custom Method
    //create region
    func makeRegion() {
        
        region = MKCoordinateRegion()
        region.center.latitude = 24.8890729
        region.center.longitude = 67.0626648
        region.span = MKCoordinateSpanMake(0.58, 0.58)
        self.mapView.setRegion(region, animated: true)
        
    }
    
    //create region for circle on map
    func loadOverlayForRegionWithLatitude(_ latitude: Double, andLongitude longitude: Double) {
        
        let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        circle = MKCircle(center: coordinates, radius: 200)
        self.mapView.setRegion(MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: 7, longitudeDelta: 7)), animated: true)
        //        let reg = MKCoordinateRegionMakeWithDistance(coordinates, 1500, 1500)
        //        self.mapView.setRegion(reg, animated: true)
        
        self.mapView.add(circle)
    }
}

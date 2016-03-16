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
    
    @IBAction func addRegion(sender: AnyObject) {
        
        loadOverlayForRegionWithLatitude(loc.currentLocation.coordinate.latitude, andLongitude: loc.currentLocation.coordinate.longitude)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        makeRegion()
        loadOverlayForRegionWithLatitude(region.center.latitude, andLongitude: region.center.longitude)
    }
    
    @IBAction func updateLocation(sender: AnyObject) {

        
        let userLocation = mapView.userLocation
        
        let region = MKCoordinateRegionMakeWithDistance(
            userLocation.location!.coordinate, 2000, 2000)
        
        mapView.setRegion(region, animated: true)

    }
    
    
    @IBAction func monitorRegion(sender: AnyObject) {
        
        loc.locmanager.requestAlwaysAuthorization()
        let centre = region.center
        let circularRegion = CLCircularRegion(center: centre, radius: 200, identifier: "Work")
        loc.locmanager.startMonitoringForRegion(circularRegion)
    }
    
    //create region
    func makeRegion() {
        
        region = MKCoordinateRegion()
        region.center.latitude = 24.8890729
        region.center.longitude = 67.0626648
        region.span = MKCoordinateSpanMake(0.58, 0.58)
        self.mapView.setRegion(region, animated: true)
        
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        
        let userLocation = mapView.userLocation
       
        mapView.centerCoordinate = userLocation.coordinate
        let dropPin = MKPointAnnotation()
        dropPin.coordinate = region.center
        dropPin.title = "Add"
        mapView.addAnnotation(dropPin)
        
        
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        
        circleRenderer = MKCircleRenderer(overlay: overlay)
        circleRenderer.fillColor = UIColor.redColor().colorWithAlphaComponent(0.1)
        circleRenderer.strokeColor = UIColor.redColor()
        circleRenderer.lineWidth = 1
        return circleRenderer
        
    }
    
    func loadOverlayForRegionWithLatitude(latitude: Double, andLongitude longitude: Double) {
        
        let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        circle = MKCircle(centerCoordinate: coordinates, radius: 200)
        self.mapView.setRegion(MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: 7, longitudeDelta: 7)), animated: true)
//        let reg = MKCoordinateRegionMakeWithDistance(coordinates, 1500, 1500)
//        self.mapView.setRegion(reg, animated: true)

        self.mapView.addOverlay(circle)
    }
    
    
    

    
}
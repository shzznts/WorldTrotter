//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Lincoln Sea on 3/30/16.
//  Copyright © 2016 Lincoln Sea. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    var mapView: MKMapView!
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Map loaded")
    }
    
    override func loadView() {
        mapView = MKMapView()
        mapView.delegate = self
        view = mapView
        
        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satelite"])
        segmentedControl.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(MapViewController.mapTypeChanged(_:)), forControlEvents: .ValueChanged)
        view.addSubview(segmentedControl)
        
        let margins = view.layoutMarginsGuide
        let topConstraint = segmentedControl.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor, constant: 8)
        let leadingConstraint = segmentedControl.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor)
        topConstraint.active = true
        leadingConstraint.active = true
        trailingConstraint.active = true
        
        let showUserLocation = UIButton()
        showUserLocation.addTarget(self, action: #selector(MapViewController.showUserLocationPressed(_:)), forControlEvents: .TouchUpInside)
        showUserLocation.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(showUserLocation)
        showUserLocation.layer.borderColor = UIColor.blackColor().CGColor
        showUserLocation.layer.borderWidth = CGFloat(1)
        showUserLocation.layer.backgroundColor = UIColor.grayColor().CGColor
        let btnTopConstraint = showUserLocation.topAnchor.constraintEqualToAnchor(segmentedControl.bottomAnchor, constant: 10)
        let btnleadingConstraint = showUserLocation.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor)
        let bntWidthConstraint = showUserLocation.widthAnchor.constraintEqualToAnchor(margins.widthAnchor)
        btnTopConstraint.active = true
        btnleadingConstraint.active = true
        bntWidthConstraint.active = true
        showUserLocation.setTitle("Show My Location", forState: .Normal)
        showUserLocation.setTitleColor(UIColor.blueColor(), forState: .Normal)
        
    }
    
    func mapViewWillStartLocatingUser(mapView: MKMapView) {
        print("started locating")
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        print("auth changed")
        if status == .AuthorizedWhenInUse {
            print("authorized")
        }
        manager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("updated locations: \(locations)")
    }
    
    func showUserLocationPressed(btn: UIButton) {
        print("button pressed")
    
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            manager.startUpdatingLocation()
            mapView.showsUserLocation = true
        } else {
            manager.requestWhenInUseAuthorization()
        }
    }
    
    func mapTypeChanged(segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .Standard
        case 1:
            mapView.mapType = .Hybrid
        case 2:
            mapView.mapType = .Satellite
        default:
            break
        }
    }
}

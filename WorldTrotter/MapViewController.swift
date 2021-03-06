//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Home on 1/10/16.
//  Copyright © 2016 Home. All rights reserved.
//

import Foundation
import UIKit
import MapKit

public class MapViewController: UIViewController {
    var mapView: MKMapView!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        print("MapViewController loaded its view.")
    }
    
    override public func loadView() {
        mapView = MKMapView()
        view = mapView
        
        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        segmentedControl.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: "mapTypeChanged:", forControlEvents: .ValueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        let topConstraint = segmentedControl.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor, constant: 8)
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor)
        
        topConstraint.active = true
        leadingConstraint.active = true
        trailingConstraint.active = true
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

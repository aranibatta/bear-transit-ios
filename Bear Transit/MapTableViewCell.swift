//
//  MapTableViewCell.swift
//  Bear Transit
//
//  Created by Daylen Yang on 10/13/14.
//  Copyright (c) 2014 Daylen Yang. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class MapTableViewCell : UITableViewCell {
    
    let mapView = MKMapView()
    let zoomSpan = 0.01
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(mapView)
        
        mapView.setTranslatesAutoresizingMaskIntoConstraints(false)
        mapView.showsUserLocation = true
        mapView.showsBuildings = true
        mapView.showsPointsOfInterest = true
        
        let c1 = NSLayoutConstraint(item: mapView, attribute: .Top, relatedBy: .Equal, toItem: contentView, attribute: .Top, multiplier: 1, constant: 0)
        let c2 = NSLayoutConstraint(item: mapView, attribute: .Bottom, relatedBy: .Equal, toItem: contentView, attribute: .Bottom, multiplier: 1, constant: 0)
        let c3 = NSLayoutConstraint(item: mapView, attribute: .Leading, relatedBy: .Equal, toItem: contentView, attribute: .Leading, multiplier: 1, constant: 0)
        let c4 = NSLayoutConstraint(item: mapView, attribute: .Trailing, relatedBy: .Equal, toItem: contentView, attribute: .Trailing, multiplier: 1, constant: 0)
        
        contentView.addConstraints([c1, c2, c3, c4])
        
    }
    
    func dropPin(lat: Double, lon: Double) {
        let pin = MKPointAnnotation()
        pin.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        mapView.addAnnotation(pin)
        
        let region = MKCoordinateRegion(center: pin.coordinate, span: MKCoordinateSpanMake(zoomSpan, zoomSpan))
        mapView.setRegion(region, animated: false)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
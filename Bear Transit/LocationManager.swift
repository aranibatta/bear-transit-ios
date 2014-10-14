//
//  LocationManager.swift
//  Bear Transit
//
//  Created by Daylen Yang on 10/9/14.
//  Copyright (c) 2014 Daylen Yang. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate {
    
    func didGetLocation(location : CLLocation)
    func didGetLocationError(error: NSError)
    func didGetPermissionError()
    
}

class LocationManager : NSObject, CLLocationManagerDelegate {
    
    let clManager = CLLocationManager()
    var delegate : LocationManagerDelegate
    
    init(delegate : LocationManagerDelegate) {
        self.delegate = delegate
        super.init()
        clManager.delegate = self
    }
    
    func getLocation() {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .Authorized, .AuthorizedWhenInUse:
                clManager.startUpdatingLocation()
            case .Denied, .Restricted:
                delegate.didGetPermissionError()
            case .NotDetermined:
                clManager.requestWhenInUseAuthorization()
            }
        } else {
            delegate.didGetPermissionError()
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        let location: CLLocation? = locations.last as? CLLocation
        if location != nil {
            clManager.stopUpdatingLocation()
            delegate.didGetLocation(location!)
        }
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        delegate.didGetLocationError(error)
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .Authorized, .AuthorizedWhenInUse:
            clManager.startUpdatingLocation()
        case .Denied, .Restricted:
            delegate.didGetPermissionError()
        default:
            break
        }
    }
    
}
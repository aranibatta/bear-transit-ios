//
//  StopsTableViewController.swift
//  Bear Transit
//
//  Created by Daylen Yang on 10/9/14.
//  Copyright (c) 2014 Daylen Yang. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class StopsTableViewController: UITableViewController, LocationManagerDelegate {
    
    let locationManager : LocationManager?
    
    override init() {
        super.init()
        locationManager = LocationManager(delegate: self)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        locationManager = LocationManager(delegate: self)
    }
    
    override func viewDidLoad() {
        locationManager!.getLocation()
    }
    
    func didGetLocation(location : CLLocation) {
        println(location.description)
    }
    
    func didGetLocationError(error: NSError) {
        println(error.description)
    }
    
    func didGetPermissionError() {
        let alert = UIAlertController(title: "Could not get location", message: "Permission was denied. Please give permission to access location.", preferredStyle: UIAlertControllerStyle.Alert)
        let button = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(button)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}
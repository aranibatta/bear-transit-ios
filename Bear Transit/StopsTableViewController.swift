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
import Alamofire

class StopsTableViewController: UITableViewController, LocationManagerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var locationManager : LocationManager?
    
    // MARK: - Init
    override init() {
        super.init()
        sharedInit()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    func sharedInit() {
        locationManager = LocationManager(delegate: self)
    }
    
    override func viewDidLoad() {
        locationManager!.getLocation()
    }
    
    // MARK: - UI
    
    func updateStopsTable(stops : [AnyObject]) {
        println(stops)
    }
    
    // MARK: - LocationManagerDelegate
    
    func didGetLocation(location : CLLocation) {
        println(location.description)
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        Alamofire.request(.GET, "https://beartransit.daylen.com/api/v1/stops?lat=\(lat)&lon=\(lon)")
            .responseJSON { (request, response, json, error) -> Void in
                self.updateStopsTable(json as [AnyObject])
        }
    }
    
    func didGetLocationError(error: NSError) {
        AlertUtils.showAlert(self, title: "Could not get location", message: error.localizedDescription)
    }
    
    func didGetPermissionError() {
        AlertUtils.showAlert(self, title: "Could not get location", message: "Permission was denied. Please give permission to access your location.");
    }
    
}
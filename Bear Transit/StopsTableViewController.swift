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
    var stops : [Stop] = []
    
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
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.beginRefreshing()
        locationManager!.getLocation()
    }
    
    // MARK: - UITableViewDataSource
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stops.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "StopCell")
        cell.textLabel?.text = stops[indexPath.row].name
        cell.detailTextLabel?.text = String(format: "%.2f miles away", stops[indexPath.row].distance)
        return cell
    }
    
    // MARK: - UI
    
    func updateStopsTable(stops : [AnyObject]) {
        self.stops = []
        for stop in stops {
            let stopDict = stop as NSDictionary
            let stopObj = Stop(identifier: stopDict["id"] as String, name: stopDict["name"] as String, lat: stopDict["lat"] as Double, lon: stopDict["lon"] as Double, distance: stopDict["dist"] as Double)
            self.stops.append(stopObj)
        }
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
        println(self.stops)
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
        self.refreshControl?.endRefreshing()
        AlertUtils.showAlert(self, title: "Could not get location", message: error.localizedDescription)
    }
    
    func didGetPermissionError() {
        self.refreshControl?.endRefreshing()
        AlertUtils.showAlert(self, title: "Could not get location", message: "Permission was denied. Please give permission to access your location.");
    }
    
}
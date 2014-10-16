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
        self.refreshControl?.addTarget(self, action: Selector("triggerUpdate"), forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl?.beginRefreshing()
    }
    
    func triggerUpdate() {
        // TODO: your code here
        // Fetch the user's location
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // TODO: your code here
        // Find the tapped object and perform a segue
    }
    
    // MARK: - UITableViewDataSource
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stops.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // TODO: your code here
        // Return a configured table view cell
        return UITableViewCell(style: .Default, reuseIdentifier: "")
    }
    
    // MARK: - Callbacks
    
    func updateStopsTable(stops : [AnyObject]) {
        // TODO: your code here
        // Convert JSON into Stop objects and store them in the array
    }
    
    // MARK: - LocationManagerDelegate
    
    func didGetLocation(location : CLLocation) {
        let lat = 0
        let lon = 0
        let url = "\(API_ROOT)stops?lat=\(lat)&lon=\(lon)"
        // TODO: your code here
        // Make an API request to fetch the closest bus stops
    }
    
    func didGetLocationError(error: NSError) {
        self.refreshControl?.endRefreshing()
        AlertUtils.showAlert(self, title: "Could not get location", message: error.localizedDescription)
    }
    
    func didGetPermissionError() {
        self.refreshControl?.endRefreshing()
        AlertUtils.showAlert(self, title: "Could not get location", message: "Permission was denied. Please give permission to access your location.")
    }
    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // TODO: your code here
        // Configure an attribute on the target view controller
    }
    
}
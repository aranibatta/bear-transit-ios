//
//  StopView.swift
//  Bear Transit
//
//  Created by Daylen Yang on 10/13/14.
//  Copyright (c) 2014 Daylen Yang. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class StopTableViewController: UITableViewController {
    
    var stop : Stop?
    
    override func viewDidLoad() {
        navigationItem.title = stop?.name
        let time = Int(NSDate().timeIntervalSince1970) * 1000
        let requestURL = "\(API_ROOT)stop/\(stop!.getSafeIdentifier())?time=\(time)"
        println(requestURL)
        Alamofire.request(.GET, requestURL).responseJSON { (request, response, json, error) -> Void in
            if (error != nil) {
                println(error)
                AlertUtils.showAlert(self, title: "Connection error", message: "\(error?.description)")
            } else {
                self.populateNextBusCells(json as Dictionary<String, AnyObject>)
            }
        }
    }
    
    func populateNextBusCells(info : Dictionary<String, AnyObject>) {
        println(info)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.section == 0) {
            return 200
        } else {
            return 44
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            // Return the map
            let mapCell = MapTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "MapCell")
            mapCell.dropPin(stop!.lat, lon: stop!.lon)
            return mapCell
        } else {
            // TODO
            return UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "")
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 // TODO
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1 // TODO
    }
    
}
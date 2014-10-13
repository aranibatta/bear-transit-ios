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
    var departures : [Dictionary<String, AnyObject>] = []
    
    override func viewDidLoad() {
        navigationItem.title = stop?.name
        self.tableView.registerNib(UINib(nibName: "NextBusTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "NextBusCell")
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
        var next: AnyObject? = info["next"] as AnyObject?
        if let next: AnyObject = next {
            departures = next as [Dictionary<String, AnyObject>]
            tableView.reloadData()
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.section == 0) {
            return 250
        } else {
            return 60
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            // Return the map
            let mapCell = MapTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "MapCell")
            mapCell.dropPin(stop!.lat, lon: stop!.lon)
            return mapCell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("NextBusCell") as NextBusTableViewCell
            cell.backgroundColor = UIColor(red: 26/255.0, green: 101/255.0, blue: 71/255.0, alpha: 1.0)
            cell.lineName.text = (departures[indexPath.row]["line"]! as String)
            let destination = departures[indexPath.row]["line_note"]! as String
            cell.lineNote.text = "To \(destination)"
            cell.timeOne.text = "LOL"
            cell.timeTwo.text = "2"
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return departures.count
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
}
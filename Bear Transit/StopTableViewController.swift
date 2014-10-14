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
            if error != nil {
                println(error)
                AlertUtils.showAlert(self, title: "Connection error", message: error!.localizedDescription)
            } else {
                self.saveNextBusCellsData(json as Dictionary<String, AnyObject>)
            }
        }
    }
    
    func saveNextBusCellsData(info : Dictionary<String, AnyObject>) {
        var next: AnyObject? = info["next"] as AnyObject?
        if let next: AnyObject = next {
            departures = next as [Dictionary<String, AnyObject>]
            tableView.reloadData()
            if departures.count == 0 {
                AlertUtils.showAlert(self, title: "No active lines", message: "No Bear Transit lines are running right now.")
            }
        }
    }
    
    func getTimeDifference(time : Int) -> String {
        let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        
        let now = NSDate()
        let components = calendar.components(NSCalendarUnit.YearCalendarUnit|NSCalendarUnit.MonthCalendarUnit|NSCalendarUnit.DayCalendarUnit, fromDate: now)
        components.hour = time / 100
        components.minute = time % 100
        let future = calendar.dateFromComponents(components)
        
        let diff = calendar.components(NSCalendarUnit.HourCalendarUnit|NSCalendarUnit.MinuteCalendarUnit, fromDate: now, toDate: future!, options: .allZeros)
        let hours = diff.hour
        let mins = diff.minute
        if hours > 0 {
            return "\(hours)h \(mins)m"
        } else {
            return "\(mins) min"
        }
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return (indexPath.section == 0) ? 250 : 60
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            // Return the map
            let mapCell = MapTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "MapCell")
            mapCell.dropPin(stop!.lat, lon: stop!.lon)
            return mapCell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("NextBusCell") as NextBusTableViewCell
            
            // Configure the cell
            cell.backgroundColor = UIColor(red: 26/255.0, green: 101/255.0, blue: 71/255.0, alpha: 1.0)
            
            // Configure the left side of the cell
            cell.lineName.text = (departures[indexPath.row]["line"]! as String)
            let destination = departures[indexPath.row]["line_note"]! as String
            cell.lineNote.text = "To \(destination)"
            
            // Configure the right side of the cell
            let times = departures[indexPath.row]["times"]! as [Int]
            cell.timeOne.text = getTimeDifference(times.first!)
            cell.timeTwo.text = times.count > 1 ? getTimeDifference(times[1]) : ""
            
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 0) ? 1 : departures.count
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
}
//
//  AlertUtils.swift
//  Bear Transit
//
//  Created by Daylen Yang on 10/9/14.
//  Copyright (c) 2014 Daylen Yang. All rights reserved.
//

import Foundation
import UIKit

class AlertUtils {
    class func showAlert(vc : UIViewController, title : String, message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let button = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
        alert.addAction(button)
        vc.presentViewController(alert, animated: true, completion: nil)
    }
}
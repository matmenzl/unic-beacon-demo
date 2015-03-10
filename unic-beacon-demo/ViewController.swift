//
//  ViewController.swift
//  unic-beacon-demo
//
//  Created by Mathias Menzl on 10/12/14.
//  Copyright (c) 2014 Mathias Menzl. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let LocationManager = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D"), identifier: "unic beacons")
    let colors = [
        60706: UIColor(red: 84/255, green: 77/255, blue: 160/255, alpha: 1),
        64305: UIColor(red: 142/255, green: 212/255, blue: 220/255, alpha: 1),
        5894: UIColor(red: 162/255, green: 213/255, blue: 181/255, alpha: 1)
    ]

     override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        LocationManager.delegate = self
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedWhenInUse) {
            LocationManager.requestWhenInUseAuthorization()
        }
        LocationManager.startRangingBeaconsInRegion(region)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        let knownBeacons = beacons.filter{ $0.proximity != CLProximity.Unknown }
        if (knownBeacons.count > 0) {
            let closestBeacon = knownBeacons[0] as CLBeacon
            self.view.backgroundColor = self.colors[closestBeacon.minor.integerValue]
        }
    }

}


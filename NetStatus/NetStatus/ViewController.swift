//
//  ViewController.swift
//  NetStatus
//
//  Created by Infraestructura on 7/26/19.
//  Copyright © 2019 Daniel Rosales. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var ac:UIAlertController?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let reach = Reachability(hostName: "www.google.com"){
            let mensaje = ""
            var confirma = false
            let netStat = reach.currentReachabilityStatus()
            switch (netStat){
            case NotReachable: print ("no hay conexión")
            case ReachableViaWiFi: print ("la conexión es WIFI")
            //case ReachableViaWWAN: print ("La conexión es por datos...procedo?")
            default: print ("La conexión es por datos...procedo?")
            }
            ac = UIAlertController(title: "NetStatus", message: mensaje, preferredStyle: .alert)
            let aaOK = UIAlertAction(title: "OK", style: default, handler: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}


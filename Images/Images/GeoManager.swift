//
//  GeoManager.swift
//  Images
//
//  Created by Infraestructura on 8/3/19.
//  Copyright © 2019 Daniel Rosales. All rights reserved.
//

import Foundation
import CoreLocation

class GeoManager: NSObject, CLLocationManagerDelegate {

    var lastKnowLocation: CLLocationCoordinate2D?
    
    private var locationManager:CLLocationManager = CLLocationManager()
    
    // MARK: CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    lastKnowLocation = locations.first?.coordinate
        print("el usuario está en \(lastKnowLocation?.latitude), \(lastKnowLocation?.longitude)")
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // TODO: no se pueden obtener lecturas...qué procede?
        //locationManagerUp.stopdatingLocation()
    }
    
    // MARK: -Custom methods
    func startMonitoriningLocation(){
        //Consultar el status de la autorización para usar GPS
        let authorizationStatus = CLLocationManager.authorizationStatus()
        if authorizationStatus == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
        else{
        locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func stopMonitoriningLocation(){
        locationManager.stopUpdatingLocation()
    }
    
    // MARK: - Object life cycle
   /*   Singleton   */
   static let shared  = GeoManager()
    
    private override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
       // locationManager.distanceFilter = 10 // que tanto se tiene que mover el dispositivo para que el locationManager indique que te has movido en metros
        locationManager.delegate = self
    }
    /*              */
}

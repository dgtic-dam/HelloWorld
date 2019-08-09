//
//  MyPin.swift
//  Images
//
//  Created by Infraestructura on 8/9/19.
//  Copyright © 2019 Daniel Rosales. All rights reserved.
//

import Foundation
import MapKit

class MyPin: NSObject, MKAnnotation{
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    
    init (_ coordinate:CLLocationCoordinate2D, _ title:String){
        self.coordinate = coordinate
        self.title = title
    }
}

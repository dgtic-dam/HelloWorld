//
//  Imagen+CoreDataProperties.swift
//  Images
//
//  Created by Infraestructura on 8/3/19.
//  Copyright © 2019 Daniel Rosales. All rights reserved.
//
//

import Foundation
import CoreData


extension Imagen {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Imagen> {
        return NSFetchRequest<Imagen>(entityName: "Imagen")
    }

    @NSManaged public var guid: String?
    @NSManaged public var path: String?
    @NSManaged public var titulo: String?
    @NSManaged public var lon: Double
    @NSManaged public var lat: Double

}

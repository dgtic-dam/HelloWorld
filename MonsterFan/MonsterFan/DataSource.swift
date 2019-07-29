//
//  DataSource.swift
//  MonsterFan
//
//  Created by Daniel Rosales on 7/29/19.
//  Copyright © 2019 Daniel Rosales. All rights reserved.
//

import Foundation
import UIKit

class DataSource: NSObject {
    static func getJsonArray() -> [[String:Any?]] {
        // 1) Tener el "string" de la URL
        // Para archivo local
        // guard let a = 2, let b = 3
        guard let url = URL(string: "http://janzelaznog.com/DDAM/iOS/gaga/info.json") else { return [] }
        // Para archivo remoto
        // guard let urlStr = "http://archivo.remoto/archivo.json"
        // let url = URL(string:urlSTR)
        do {
            //Data representa un arreglo de bytes
            let bytes = try Data(contentsOf: url)
            let temp = try JSONSerialization.jsonObject(with: bytes, options:.allowFragments)
            return temp as! [[String:Any?]] //forzoso un arreglo de diccionarios
        }
        catch{
            print ("error al abrir el JSON " + error.localizedDescription)
        }
        return []
    }
}

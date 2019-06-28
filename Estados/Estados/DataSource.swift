//
//  DataSource.swift
//  Estados
//
//  Created by Infraestructura on 6/28/19.
//  Copyright © 2019 Dan Ros. All rights reserved.
//

import UIKit

class DataSource: NSObject {
    static func getJsonArray() -> [[String:Any?]] {
        // 1) Tener el "string" de la URL
        // Para archivo local
        // guard let a = 2, let b = 3
        guard let urlStr = Bundle.main.path(forResource: "estados", ofType: "json") else { return [] }
        guard let url = URL(string: "file://" + urlStr) else { return [] }
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

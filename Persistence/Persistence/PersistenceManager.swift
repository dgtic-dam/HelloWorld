//
//  PersistenceManager.swift
//  Persistence
//
//  Created by Mac Mini Edg3 on 22/06/18.
//  Copyright © 2018 janzelaznog. All rights reserved.
//

import UIKit

enum PersistenceType:Int  {
    case userDefaults = 0
    case plistFile
    case jsonFile
}

class PersistenceManager: NSObject {
    static let instance = PersistenceManager()
    let fileManager = FileManager.default
    var rutaPlist = ""
    var rutaJson = ""
    
    var dictJSON:[String:String] = [:]
    var dictPlist:[String:String] = [:]
    
    // Para impedir la inicialización
    private override init() {
        super.init()
        cargaArchivos()
    }
    
    private func cargaArchivos() {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let rutaArchivos = documentDirectory
        rutaPlist = rutaArchivos + "/persistence.plist"
        if fileManager.fileExists(atPath: rutaPlist) {
            if let url = URL(string:rutaPlist) {
                do {
                    let data = try Data(contentsOf:url)
                    let tmp = try PropertyListSerialization.propertyList(from:data, options: .mutableContainers, format:nil)
                    dictPlist = tmp as! [String:String]
                }
                catch {
                    
                }
            }
        }
        rutaJson = rutaArchivos + "/persistence.json"
        if fileManager.fileExists(atPath: rutaJson) {
            if let url = URL(string:rutaJson) {
                do {
                    let data = try Data(contentsOf:url)
                    let tmp = try JSONSerialization.jsonObject(with:data, options:.allowFragments)
                    dictJSON = tmp as! [String:String]
                }
                catch {
                    
                }
            }
        }
    }
    
    public static func getInstance() -> PersistenceManager {
        return PersistenceManager.instance
    }
    
    public func guarda(_ val:String, enKey:String, tipo:PersistenceType) -> Bool {
        var result = false
        switch (tipo) {
            case .plistFile:result = guardaEnPlist(key:enKey, val:val)
            case .jsonFile:result = guardaEnJson(key:enKey, val:val)
            default:result = guardaEnUserDefaults(key:enKey, val:val)
        }
        
        return result
    }
    
    private func guardaEnPlist (key:String, val:String) -> Bool {
        dictPlist[key] = val
        if let url = URL(string:rutaPlist) {
            do {
                let data = try PropertyListSerialization.data(fromPropertyList:dictPlist, format: .xml, options:0)
                try data.write(to:url)
                return true
            }
            catch {
            
            }
        }
        return false
    }
    
    private func guardaEnJson(key:String, val:String) -> Bool {
        dictJSON[key] = val
        if let url = URL(string:rutaJson) {
            do {
                let data = try JSONSerialization.data(withJSONObject: dictJSON, options: .prettyPrinted)
                try data.write(to:url)
                return true
            }
            catch {
                
            }
        }
        return false
    }
    
    private func guardaEnUserDefaults(key:String, val:String) -> Bool {
        let ud = UserDefaults.standard
        ud.set(val, forKey: key)
        ud.synchronize()
        return true
    }
}

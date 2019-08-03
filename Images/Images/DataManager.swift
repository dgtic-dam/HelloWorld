//
//  DataManager.swift
//  Images
//
//  Created by Infraestructura on 8/2/19.
//  Copyright © 2019 Daniel Rosales. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DataManager:NSObject{
    
    // Implementación Singleton  //
    static var shared = DataManager()
    
    private override init(){
        super.init()
    }
    /*****************************/
    
    // property de tipo lazy var: Retardar la inicialización, solo cuando sea necesario
    lazy var persistentContainer:NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Images") // name: "nombre del modelo", mismo nombre del sqlite que se va a generar
        container.loadPersistentStores(completionHandler: {
            (storeDescription, error) in
            if error != nil {
                //TODO: que hago? cierro la app? exit(666)
                print("error al crear la BD en: \(storeDescription). \(error!.localizedDescription)")
            }
        })
        return container
    }() //Se ejecuta cuando se inicializa
    
    
    
    func saveImage(_ image:UIImage, titulo:String){
        // encontrar la ubicación Library
        let libraryURL = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first
        let hoy = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyyMMdd_HHmmss"
        let nombreFoto = df.string(from: hoy) + ".jpg" //Todas las fotos del dispositivo se manejan como .jpg
        let urlFoto = libraryURL?.appendingPathComponent(nombreFoto)
        print("imagen guardada como: \(urlFoto?.absoluteString)")
        let bytes = image.jpegData(compressionQuality: 1.0)
        do {
            try bytes?.write(to: urlFoto!)  //Guardar bytes en un archivo
            //guardo en la BD
            let imagen = NSEntityDescription.insertNewObject(forEntityName: "Imagen", into: self.persistentContainer.viewContext) as! Imagen //Objeto ManagedObject
            imagen.titulo = titulo
            imagen.path = urlFoto!.path
            imagen.guid = UUID().uuidString
            try self.persistentContainer.viewContext.save()
        }
        catch{
            print("Ocurrió un error al guardar: \(error.localizedDescription)")
        }
    }
}

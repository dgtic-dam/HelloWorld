//
//  ViewController.swift
//  Batman
//
//  Created by Infraestructura on 8/9/19.
//  Copyright © 2019 Daniel Rosales. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    var filePath:URL?
    var coordenadas:[CLLocationCoordinate2D] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let destination = DownloadRequest.suggestedDownloadDestination()
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        filePath = documentsPath?.appendingPathComponent("BatmanLocations.plist")
        if FileManager.default.fileExists(atPath: filePath!.path){
            do{
                try FileManager.default.removeItem(atPath: filePath!.path)
                
            }
            catch{
                
            }
        }
        
        Alamofire.download("http://janzelaznog.com/DDAM/iOS/BatmanLocations.plist", to: destination).downloadProgress(queue: DispatchQueue.global(qos: .utility)){
            (progress) in
            print("Progress: \(progress.fractionCompleted)")
            } .validate().responseData { (response) in
                if response.error == nil{
                    print(response.destinationURL!.absoluteString)
                    self.parsePlist()
                }
        }
    }

    
    func parsePlist(){
        do{
            let bytes = try Data(contentsOf: filePath!)
            let plistObj = try PropertyListSerialization.propertyList(from: bytes, options: .mutableContainers, format: nil) as! [String]
            let puntos = plistObj.map {NSCoder.cgPoint(for: $0)}
            coordenadas = puntos.map {CLLocationCoordinate2DMake(CLLocationDegrees($0.x), CLLocationDegrees($0.y))}
            print(puntos)
            self.drawMap()
        }
        catch{
            print("Error al procesar el archivo \(error.localizedDescription)")
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? { //Método delegado del mapa
        let tmpPin = annotation as! MyPin
        print (tmpPin.category)
       var batiPin = mapView.dequeueReusableAnnotationView(withIdentifier: "batiPin") //Se reutiliza el pin
        if batiPin == nil{
            batiPin = MKAnnotationView(annotation: annotation, reuseIdentifier: "batiPin")
            batiPin?.image = UIImage(named: "batman-yellow")
            batiPin?.canShowCallout = true
        }
        return batiPin
    }
    
    
    func drawMap(){
        let myMap = MKMapView(frame: self.view.bounds)
        self.view.addSubview(myMap)
        myMap.delegate = self
        let pines = coordenadas.map{MyPin($0, "Batman was Here!")} // Recorre el arreglo
        /*
         //Lo mismo pero con for each
         var pines = []
        for coord in coordenadas{
            let unPin = MyPin(coord, "Batman!")
            pines.append(unPin)
        }
         */
        myMap.showAnnotations(pines, animated: true)
        /*
         //Aumentar el radio
        var region = myMap.region
        region.span = MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)
        myMap.setRegion(region, animated: true)
         */
    }
}

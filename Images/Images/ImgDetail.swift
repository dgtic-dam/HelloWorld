//
//  ImgDetail.swift
//  Images
//
//  Created by Infraestructura on 8/9/19.
//  Copyright © 2019 Daniel Rosales. All rights reserved.
//

import UIKit
import MapKit

class ImgDetail: UIViewController {
    
    //TAREA: Completa la práctica 2, para que desde el collection view se envíen estos dos valores y se presenten correctamente la interfaz
    var coordenada : CLLocationCoordinate2D?
    var imgNombre: String?
    var lat: Double?
    var lon: Double?
    var infoPic:[Imagen] = []
    
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var mapType: UISegmentedControl!
    @IBOutlet weak var mapDetail: MKMapView!
    @IBOutlet weak var shareButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //UNAM
        coordenada = CLLocationCoordinate2D(latitude: lat!, longitude: lon!)
        //coordenada = CLLocationCoordinate2D(latitude: 19.3072787, longitude: -99.1287316)
        print("Lat \(lat) and Lon \(lon)")
        print("Name: \(imgNombre)")
        let region = MKCoordinateRegion(center: coordenada!, latitudinalMeters: 500.0, longitudinalMeters: 500.0)
        mapDetail.setRegion(region, animated: true)
        let losPines = mapDetail.annotations //Da todos los pines en el mapa
        mapDetail.removeAnnotations(losPines) //eliminamos todos los pines que haya previamente
        let elPin = MyPin(coordenada!,  "Ud. Está aquí")
        mapDetail.addAnnotation(elPin)
        
        let libraryURL = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first
        if let urlFoto = libraryURL?.appendingPathComponent(imgNombre!){
            print("URLFoto: \(urlFoto)")
            if let bytes = try? Data(contentsOf: urlFoto) {
                Image.image = UIImage(data: bytes)
                print("Image: \(Image)")
            }
        }
    }
    
    @IBAction func btnCompartirTouch(_ sender: Any) {
        let items = [Image.image, "Mira mi foto"] as [Any]
        let  avc = UIActivityViewController(activityItems: items, applicationActivities: nil) //applicationActivities es para mostrar o restringir las aplicaciones
        if UIDevice.current.userInterfaceIdiom == .pad{
            avc.modalPresentationStyle = .popover
            let popover = avc.popoverPresentationController
            popover?.sourceView = shareButton
            popover?.sourceRect = shareButton.bounds
            popover?.permittedArrowDirections = .any
        }
            self.present(avc, animated: true)
    }
    
    @IBAction func scTipoChange(_ sender: Any) {
        switch (mapType.selectedSegmentIndex) {
        case 1:
            mapDetail.mapType = .satellite
        case 2:
            mapDetail.mapType = .hybrid
        default:
            mapDetail.mapType = .standard
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Image.backgroundColor = UIColor.init(red: 41.0, green: 255, blue: 214, alpha: 31.0) //#29FFD6
        Image.backgroundColor = UIColor.gray
        shareButton.setBackgroundImage(UIImage(named: "share_android"), for: .normal)
        shareButton.setTitle("", for: .normal)
        // Do any additional setup after loading the view.
    }
    
    //Se manda a llamar cada que hace un cambio de vista
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
            let margins = self.view.layoutMarginsGuide
            Image.translatesAutoresizingMaskIntoConstraints = false
            Image.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 0.0).isActive = true
            Image.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 0.0).isActive = true
            Image.topAnchor.constraint(equalTo: margins.topAnchor, constant: 0.0).isActive = true
            Image.heightAnchor.constraint(equalTo: margins.heightAnchor, multiplier: 0.5).isActive = true
        
            mapType.translatesAutoresizingMaskIntoConstraints = false
            mapType.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 0.0).isActive = true
            mapType.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 0.0).isActive = true
            mapType.topAnchor.constraint(equalTo: Image.bottomAnchor, constant: 0.0).isActive = true
        
            shareButton.translatesAutoresizingMaskIntoConstraints = false
            shareButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 0.0).isActive = true
            shareButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: 0.0).isActive = true
            shareButton.widthAnchor.constraint(equalToConstant: 45)
            shareButton.heightAnchor.constraint(equalToConstant: 48)
            
            mapDetail.translatesAutoresizingMaskIntoConstraints = false
            mapDetail.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 0.0).isActive = true
            mapDetail.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 0.0).isActive = true
            mapDetail.topAnchor.constraint(equalTo: mapType.bottomAnchor, constant: 0.0).isActive = true
            mapDetail.bottomAnchor.constraint(equalTo: shareButton.topAnchor, constant: 0.0).isActive = true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

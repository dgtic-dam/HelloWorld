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
    
    var coordenada : CLLocationCoordinate2D?
    
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var mapType: UISegmentedControl!
    @IBOutlet weak var mapDetail: MKMapView!
    @IBOutlet weak var shareButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //UNAM
        coordenada = CLLocationCoordinate2D(latitude: 19.32889, longitude: -99.187222)
        let region = MKCoordinateRegion(center: coordenada!, latitudinalMeters: 500.0, longitudinalMeters: 500.0)
        mapDetail.setRegion(region, animated: true)
        let losPines = mapDetail.annotations //Da todos los pines en el mapa
        mapDetail.removeAnnotations(losPines) //eliminamos todos los pines que haya previamente
        let elPin = MyPin(coordenada!,  "Ud. Está aquí")
        mapDetail.addAnnotation(elPin)
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
    
    
    
    //Se manda a llamar cada que hace un cambio de vista
 /*   override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let marginsGuide = self.view.layoutMarginsGuide
        let screenWidth = marginsGuide.heightAnchor
        let screenHeight = marginsGuide.heightAnchor
        Image.translatesAutoresizingMaskIntoConstraints = false
        //Redimensionar imagen con constraint
        Image.leftAnchor.constraint(equalTo: marginsGuide.leftAnchor, constant: 0.0).isActive = true //Margen Izquierdo
        Image.rightAnchor.constraint(equalTo: marginsGuide.rightAnchor,constant: 0.0).isActive = true //Margen Izquierdo
        Image.widthAnchor.constraint(equalTo: screenWidth, multiplier: 1.0)
        Image.heightAnchor.constraint(equalTo: screenHeight, multiplier: 0.5)
        //Comenzará donde finaliza la imagen
        mapType.topAnchor.constraint(equalTo: Image.bottomAnchor).isActive = true
        mapType.widthAnchor.constraint(equalTo: screenWidth, multiplier: 1.0)
        //Comienza donde termina el segmented control
        mapDetail.topAnchor.constraint(equalTo: mapDetail.bottomAnchor).isActive = true
        mapDetail.widthAnchor.constraint(equalTo: screenWidth, multiplier: 1.0)
        
    }*/
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Image.backgroundColor = UIColor.init(red: 41.0, green: 255, blue: 214, alpha: 31.0) //#29FFD6
        Image.backgroundColor = UIColor.gray
        // Do any additional setup after loading the view.
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

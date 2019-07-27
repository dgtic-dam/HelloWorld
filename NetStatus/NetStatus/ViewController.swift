//
//  ViewController.swift
//  NetStatus
//
//  Created by Infraestructura on 7/26/19.
//  Copyright © 2019 Daniel Rosales. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    var ac:UIAlertController?
    var timer:Timer?

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let reach = Reachability(hostName: "www.google.com"){
            let mensaje = ""
            var confirma = true
            var isWifi = false
            let netStat = reach.currentReachabilityStatus()
            switch (netStat){
                case NotReachable: print ("no hay conexión")
                case ReachableViaWiFi: print ("la conexión es WIFI")
                    isWifi = true
                //case ReachableViaWWAN: print ("La conexión es por datos...procedo?")
                default: print ("La conexión es por datos...procedo?")
                    confirma = true
            }
            ac = UIAlertController(title: "NetStatus", message: mensaje, preferredStyle: .alert)
            //ac = UIAlertController(title: "NetStatus", message: mensaje, preferredStyle: .actionSheet)
            if !confirma {
                //Cerrar el alert automáticamente "Toast Style"
                timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false, block: {
                    (localTimer) in
                    self.ac?.dismiss(animated: true, completion: nil)
                })
            }
            else {
                let aaOK = UIAlertAction(title: "OK", style: .default, handler: nil)
                let aaNO = UIAlertAction(title: "Nein", style: .destructive, handler:{
                    (alert/*, otra cosa*/) in
                    // Que hacer si el usuario no quiere conexión de datos?
                    // ...cerrar la app
                    exit(666)
                })
                ac?.addAction(aaOK)
                ac?.addAction(aaNO)
            }
            present(ac!, animated: true, completion: nil)
            if isWifi {
                descargaContenido()
            }
        }
    }
    
    func descargaContenido(){
        let wv = WKWebView(frame: UIScreen.main.bounds)
        self.view.addSubview(wv)
 /*     //Mostrar url en WebView
         let laURLStr = "http://www.unam.mx"
        if let laURL = URL(string: laURLStr){
            let elReq = URLRequest(url: laURL)
            wv.load(elReq)
        }

        // Consumir JSON desde web
        let URLStr = "https://jsonplaceholder.typicode.com/photos"
        
        if let url = URL(string: URLStr){
            do {
                let bytes = try Data(contentsOf: url) // la clase Data representa un arreglo de bytes
                //hacer algo con el arreglo de bytes
                /*let unString = String(bytes:bytes, encoding: .utf8) //Conversión a String
                print (unString)*/
                let unJson = try JSONSerialization.jsonObject(with: bytes, options:.allowFragments)
                print (unJson)
            }
            catch {
                print ("error al abrir el JSON " + error.localizedDescription)
            }
            
        }
 */
       // let URLStr = "https://image.shutterstock.com/image-photo/new-york-april-4-2018-600w-1114115513.jpg"
        let URLStr = "https://images.unsplash.com/photo-1564166906836-377d60a31fe1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80"
        if let url = URL(string: URLStr){
            do {
                let bytes = try Data(contentsOf: url) // la clase Data representa un arreglo de bytes
                let iv = UIImageView(frame: UIScreen.main.bounds)
                iv.contentMode = .scaleAspectFit //Para que la imagen no se estire ni se pierda la resolución
                self.view.addSubview(iv)
                //Se crea un objeto UImage a partir  de los bytes obtenidos de la URL
                iv.image = UIImage(data: bytes)
            }
            catch {
                print ("error al abrir imagen " + error.localizedDescription)
            }
        //Se comenta el WebView para mostrar el image View
        }
    }// quitar al descomentar WebView
        
    /*
        let htmlString = "<span style=\"font-family:'Avenir'; font-size:16px;\"><p>Instantly turn your words into images.</p><p>Myimage aims to change the way we communicate.</p><p><span style=\"color:35a9f3;\">Think it, See it, Share it.</span> Have a story, thought, or idea? Tell it through a Wimage. Using text or voice, your words are transformed into icons, right in front of your eyes.</p><p><span style=\"color:35a9f3;\">Be creative.</span></p></span><a href='http://www.unam.mx'>CLIC AQUÍ</a>"
        wv.loadHTMLString(htmlString, baseURL: nil)
        wv.navigationDelegate = self
        
    }
    //Identifica si usuario da clic en el link
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == .linkActivated {
            print("clic en el link")
            let elReq = navigationAction.request
            if let path = elReq.url?.path{
                //aqui se puede comprobar que href es el que se cliqueó
                // identificar que contenido es el que se tiene que mostrar....
                UIApplication.shared.open(URL(string: "http://www.educandoensexualidad.com.mx")!, options:[:], completionHandler: nil)
                //para que no haga la navegación en el objeto webkview
                decisionHandler(WKNavigationActionPolicy.cancel)
            }
        }
        else{
            //Cuando se le cambia el contenido al WKView
            decisionHandler(WKNavigationActionPolicy.allow)
        }
    }
*/
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}


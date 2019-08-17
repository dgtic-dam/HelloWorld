//
//  ViewController.swift
//  Actions
//
//  Created by Infraestructura on 6/14/19.
//  Copyright © 2019 Daniel Rosales. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBAction func unwindToHome(_ unwindSegue: UIStoryboardSegue) {
        //let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }
    
    @IBOutlet weak var ResizeY: NSLayoutConstraint!
    
    @IBAction func btnEnter(_ sender: Any) {
        //var mensaje:String
        var mensaje = "" //Inferencia
        let correo = txtCorreo.text!
        let password = txtPass.text!
        if correo.isEmpty{
            mensaje = "Escribe tu correo"
        }
        else{
            let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
            let correoValido = NSPredicate(format: "SELF MATCHES %@", regex)
            if !correoValido.evaluate(with: correo){
                mensaje = "No lo sé Rick...parece falso"
            }
            else{
                let urlSTR = "http://janzelaznog.com/DDAM/iOS/WS/login.php"
                guard let cypherPass = base64Encoded(password) else {
                    let actionController = UIAlertController(title: "Error pass cypher", message: mensaje, preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    actionController.addAction(alertAction)
                    self.present(actionController, animated: true, completion: nil)
                    return
                }
                let params:Parameters = ["username": correo, "password":cypherPass]
                Alamofire.request(urlSTR, method:.post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON{ (responseData) in
                    print("Hola" + responseData.description)
                    if let data = responseData.data{
                        do {
                            
                            //Alamofire.request(urlSTR, method: post, parameters: params, encoding: JSONEncoding.default, headers: HTTPHeaders?) //Para darle formato en json
                            let jsonResponse = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                            if let code = jsonResponse["code"] as? String{
                                if code == "200" {
                                    UserDefaults.standard.set(Date(), forKey: "inicioSesion")
                                    self.performSegue(withIdentifier: "LoginOK", sender: nil)
                                }
                                else {
                                    let actionController = UIAlertController(title: "Error", message: jsonResponse["message"] as! String, preferredStyle: .alert)
                                    let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                                    actionController.addAction(alertAction)
                                    self.present(actionController, animated: true, completion: nil)
                                }
                            }
                        }
                        catch {
                            let actionController = UIAlertController(title: "Error catch", message: error.localizedDescription, preferredStyle: .alert)
                            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                            actionController.addAction(alertAction)
                            self.present(actionController, animated: true, completion: nil)
                            
                        }
                    }
                }
                
            }
        }
      /*  if mensaje != ""{
            let actionController = UIAlertController(title: "Error", message: mensaje, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            actionController.addAction(alertAction)
            self.present(actionController, animated: true, completion: nil)
            
            
        }
        else{
            
            
            
            //Navega a la siguiente vista
        /*    txtCorreo.text = ""*/
            //Guardar el timestamp del inicio de sesión
         /*   UserDefaults.standard.set(Date(), forKey: "inicioSesion")
           self.performSegue(withIdentifier: "LoginOK", sender: nil)
*/
        }*/
    }
    
    func base64Encoded(_ string:String) -> String? {
        if let data = string.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }
    
    @IBOutlet weak var txtCorreo: UITextField!
    
    @IBOutlet weak var txtPass: UITextField!
    
    @IBAction func TapInView(_ sender: Any) {
        print("tap")
        txtCorreo.resignFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        NotificationCenter.default.addObserver(self, selector: #selector(subeTeclado(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        //TODO suscribirse a la notificacion keybordWillHideNotification invocando un metodo que se llame "bajaTeclado"
        
        NotificationCenter.default.addObserver(self, selector: #selector(bajaTeclado(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        //txtCorreo.text = ""
    }
    
    @objc func subeTeclado(_ notificacion:Notification){
        print("sube Teclado")
        ResizeY.constant = -50.0
    }
    
    @objc func bajaTeclado(_ notificacion:Notification){
        print("baja Teclado")
        ResizeY.constant = 0.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       let tapGestureRecognizer = UITapGestureRecognizer(target: self ,action:#selector(TapInView(_:)))
        
        self.view.addGestureRecognizer(tapGestureRecognizer)
        
        txtCorreo.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        // called when 'return' key pressed. return NO to ignore.
        btnEnter(self) //selector para invocar btnEnter
        return true
    }


}


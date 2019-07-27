//
//  ViewController.swift
//  Images
//
//  Created by Infraestructura on 7/27/19.
//  Copyright © 2019 Daniel Rosales. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let ipc = UIImagePickerController()
    let iv = UIImageView() //Se inicializa
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let button = UIButton(frame: CGRect(x: screenWidth / 3, y: screenHeight - 200.0 , width: screenWidth / 3, height: 50.0))
        button.setTitle("Elegir Imagen", for: .normal)
        button.backgroundColor = UIColor.blue
        button.setTitleColor(UIColor.white, for: .normal)
        //button.layer.cornerRadius = button.frame.height / 2
        button.layer.cornerRadius = 10
        //button.isEnabled = false //deshabilitar botón
        button.addTarget(self, action: #selector(botonTouch), for: .touchUpInside)  //equivalente al action, selector es una llamada asíncrona a un método
        self.view.addSubview(button)
        //iv.frame = CGRect(x: 10.0, y: 40.0 , width: screenWidth-20.0, height: screenWidth) //alto del tamaño del ancho de dispositivo
        iv.frame = CGRect(x: 10.0, y: 40.0 , width: screenWidth-20.0, height: (button.frame.minY - button.frame.height)) //Se ajusta frame
        iv.contentMode = .scaleAspectFit//escala la imagen
        iv.backgroundColor = UIColor.lightGray
        //iv.layer.cornerRadius = iv.frame.height / 2
        self.view.addSubview(iv)
    }
    
    @objc func botonTouch(){ //se hace compatible con objective c con @objc
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            //Si hay cámara...preguntar al usuario de donde elegir la imagen
            //UIImagePickerController es el control del selector de imágenes, entre cámara y galería
        }
        else{
            launchImagePicker(UIImagePickerController.SourceType.photoLibrary)
        }
    }
    
    func launchImagePicker(_ type:UIImagePickerController.SourceType){ //Necesita un delegate
       // let ipc = UIImagePickerController()
        ipc.sourceType = type
        ipc.allowsEditing = true
        ipc.delegate = self
        self.present(ipc, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let laImagen = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            //Si NO se permite la edición, la imagen se va a encontrar en esta llave del Dictionary: info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                iv.image = laImagen
        } //Se busca la propiedad en el diccionario
        else{
            
        }
        ipc.dismiss(animated: true, completion: nil)
    } //Cuando se selecciona una imagen
}


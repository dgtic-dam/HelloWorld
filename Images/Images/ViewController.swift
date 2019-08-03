//
//  ViewController.swift
//  Images
//
//  Created by Infraestructura on 7/27/19.
//  Copyright © 2019 Daniel Rosales. All rights reserved.
//

import UIKit
import AVFoundation

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
    
    @objc func botonTouch() {
        // comprobar si el dispositivo está habilitado con una cámara
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            // Si hay cámara....
            // comprobar si el permiso de uso está
            let permStatus = AVCaptureDevice.authorizationStatus(for:AVMediaType.video)
            if permStatus == .notDetermined {
                AVCaptureDevice.requestAccess(for: AVMediaType.video) { (status) in
                    if status { // El usuario autorizó el uso de la cámara
                        self.launchImagePicker(UIImagePickerController.SourceType.camera)
                    }
                    else {
                        self.launchImagePicker(UIImagePickerController.SourceType.photoLibrary)
                    }
                }
            }
            else if permStatus == .denied {
                let ac = UIAlertController(title: "Error", message: "Para tomar fotos, debe autorizar el uso de la cámara desde Configuración, quiere autorizarlo ahora?", preferredStyle: .alert)
                let a1 = UIAlertAction(title: "SI", style: .default) { (alert) in
                    UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!, options: [:], completionHandler:nil)
                }
                ac.addAction(a1)
                let a2 = UIAlertAction(title: "No, usar Galería", style: .default) { (alert) in
                    self.launchImagePicker(UIImagePickerController.SourceType.photoLibrary)
                }
                ac.addAction(a2)
                present(ac, animated: true, completion: nil)
            }
            else {
                // si hay hardware y si hay permiso, preguntar al usuario de donde elegir la imagen
                let ac = UIAlertController(title: "Elegir foto", message: "quiere usar...", preferredStyle: .alert)
                let a1 = UIAlertAction(title: "Cámara", style: .default) { (alert) in
                    self.launchImagePicker(UIImagePickerController.SourceType.camera)
                }
                ac.addAction(a1)
                let a2 = UIAlertAction(title: "Galería", style: .default) { (alert) in
                    self.launchImagePicker(UIImagePickerController.SourceType.photoLibrary)
                }
                ac.addAction(a2)
                present(ac, animated: true, completion: nil)
            }
        }
        else {
            launchImagePicker(UIImagePickerController.SourceType.photoLibrary)
        }
    }
    
    func launchImagePicker(_ type:UIImagePickerController.SourceType){ //Necesita un delegate
       // let ipc = UIImagePickerController()
        ipc.sourceType = type
        ipc.allowsEditing = true
        ipc.delegate = self
        //Si es IPAD, mostrar el imagepicker en popover
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.present(ipc, animated: true, completion: nil)
        }
        else {
            ipc.modalPresentationStyle = .popover
            let popover = ipc.popoverPresentationController
            popover?.sourceView = self.view
            self.present(ipc, animated: true, completion: nil)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        var orientacion = "portrait"
        if UIDevice.current.orientation.isLandscape{
            orientacion = "landscape"
            print ("landscape rotation")
        }
        else{
            orientacion = "portrait"
            print ("portrait rotation")
        }
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let laImagen = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            //Si NO se permite la edición, la imagen se va a encontrar en esta llave del Dictionary: info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                iv.image = laImagen
            let ac = UIAlertController(title: "Elegir foto", message: "Define un título", preferredStyle: .alert)
            ac.addTextField(configurationHandler: { (textField) in textField.placeholder = "prueba"
            })
            let a3 = UIAlertAction(title: "OK", style: .default) { (alert) in
                let txtTitulo = ac.textFields?.first
                DataManager.shared.saveImage(laImagen, titulo: txtTitulo?.text ?? "prueba")
            }
            ac.addAction(a3)
            ipc.dismiss(animated: true) {
                self.present(ac, animated: true, completion: nil)
            }
          /*  if ipc.sourceType == .camera {
                //Resources(Bundle) //Tiempo de ejecución R
                //Salvar la imagen a photoGallery //Documents R/W
                //UIImageWriteToSavedPhotosAlbum(laImagen,nil, nil, nil)
                
                //Salvar en álbum Custom Photo Album //Documents R/W
                //CustomPhotoAlbum.shared.save(image: laImagen)
                
                //guardar a Library
            }*/
        } //Se busca la propiedad en el diccionario
        else{
            ipc.dismiss(animated: true, completion: nil)
        }
    } //Cuando se selecciona una imagen //Redimensionar
    
    //Si cancela se cierra el picker
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        ipc.dismiss(animated: true, completion: nil)
    }
    
}


//
//  ViewController.swift
//  MyImages
//
//  Created by Jan Zelaznog on 8/17/19.
//  Copyright © 2019 Jan Zelaznog. All rights reserved.
//

import UIKit
import AVFoundation //Audio/video
import Alamofire //Conexiones Remotas
import PDFKit //Exportar a pdf


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var imageName = ""
    let ipc = UIImagePickerController()
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    let up_button = UIButton()
    var miv:MyDrawingImageView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton(frame: CGRect(x: screenWidth / 3, y: screenHeight - 200.0, width: screenWidth / 3, height: 50.0))
        button.setTitle("Elegir Imagen", for:.normal)
        button.backgroundColor = UIColor.red
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = button.frame.height / 2
        button.addTarget(self, action:#selector(botonTouch), for:.touchUpInside)
        self.view.addSubview(button)
        up_button.frame = CGRect(x: screenWidth / 3, y: screenHeight - 100.0, width: screenWidth / 3, height: 50.0)
        up_button.setTitle("Enviar Imagen", for:.normal)
        up_button.backgroundColor = UIColor.red
        up_button.setTitleColor(UIColor.white, for: .normal)
        up_button.layer.cornerRadius = button.frame.height / 2
        up_button.addTarget(self, action:#selector(botonUpTouch), for:.touchUpInside)
        up_button.isHidden = true
        self.view.addSubview(up_button)
    }
    func save () {
        let directoryURL = FileManager.default.urls(for:.documentDirectory, in:.userDomainMask).first
        if let fileURL = directoryURL?.appendingPathComponent(self.imageName + ".pdf") {
            let pdfDocument = PDFDocument()
            let pdfPage = PDFPage(image: (miv?.imageView.image!)!)
            pdfDocument.insert(pdfPage!, at: 0)
            if let data = pdfDocument.dataRepresentation() {
                do {
                    try data.write(to: fileURL)
                    let ac = UIAlertController(title: "SUCCESS", message: "Imagen guardada como PDF", preferredStyle:.alert)
                    let aa = UIAlertAction(title: "Yeiii!", style: .default) {action in
                        self.miv?.removeFromSuperview()
                        self.up_button.isHidden = true
                    }
                    ac.addAction(aa)
                    self.present(ac, animated: true, completion: nil)
                    print ("file saved to \(fileURL.path)")
                }
                catch { }
            }
        }
    }
    
    @objc func botonUpTouch() {
        guard let imgData = miv?.imageView.image?.jpegData(compressionQuality: 0.5)
            else { return }
        let parameters = ["uid" : "20"] //uid de login
        Alamofire.upload(multipartFormData: { multipartFormData in multipartFormData.append(imgData, withName:"fileToUpload", fileName:self.imageName+".jpg", mimeType: "image/jpeg")
            for (key, value) in parameters {
                let sTemp = value
                multipartFormData.append((sTemp.data(using:.utf8)!), withName: key) //se mandan parametros al backend
            }
        }, to:"http://janzelaznog.com/DDAM/iOS/WS/filedb.php",
           encodingCompletion: { encodingResult in
            switch encodingResult {
                case .success(let upload, _, _):
                    upload.uploadProgress{(progress: Progress)  in
                        print(progress.fractionCompleted)
                    }
                    upload.responseJSON {response in
                        if response.result.isSuccess {
                            self.save()
                        }
                    }
                case .failure:
                    DispatchQueue.main.async { //DispatchQueue es la que maneja los thread
                    let ac = UIAlertController(title: "Error", message: "Ocurrió un error al enviar la información al servidor. Por favor reintente más tarde", preferredStyle:.alert)
                    let aa = UIAlertAction(title: "Entendido", style: .destructive, handler: nil)
                    ac.addAction(aa)
                    self.present(ac, animated: true, completion: nil)
                    }
                }
        })
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
                        self.lanzaImashPicker(UIImagePickerController.SourceType.camera)
                    }
                    else {
                        self.lanzaImashPicker(UIImagePickerController.SourceType.photoLibrary)
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
                    self.lanzaImashPicker(UIImagePickerController.SourceType.photoLibrary)
                }
                ac.addAction(a2)
                present(ac, animated: true, completion: nil)
            }
            else { // .authorized
                // si hay hardware y si hay permiso, preguntar al usuario de donde elegir la imagen
                let ac = UIAlertController(title: "Elegir foto", message: "quiere usar...", preferredStyle: .alert)
                let a1 = UIAlertAction(title: "Cámara", style: .default) { (action) in
                    self.lanzaImashPicker(UIImagePickerController.SourceType.camera)
                }
                ac.addAction(a1)
                let a2 = UIAlertAction(title: "Galería", style: .default) { (alert) in
                    self.lanzaImashPicker(UIImagePickerController.SourceType.photoLibrary)
                }
                ac.addAction(a2)
                present(ac, animated: true, completion: nil)
            }
        }
        else {
            lanzaImashPicker(UIImagePickerController.SourceType.photoLibrary)
        }
    }

    func lanzaImashPicker(_ type:UIImagePickerController.SourceType) {
        ipc.sourceType = type
        ipc.delegate = self
        //ipc.allowsEditing = true
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.present(ipc, animated: true, completion:nil)
        }
        else {
            ipc.modalPresentationStyle = .popover
            let popover = ipc.popoverPresentationController
            popover?.sourceView = self.view
            self.present(ipc, animated: true, completion:nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let laImagen =  info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            miv = MyDrawingImageView(frame:CGRect(x: 10.0, y: 40.0, width: screenWidth-20.0, height:screenHeight - 250))
            self.view.addSubview(miv!)
            miv!.imageView.image = laImagen
            let ac = UIAlertController(title: "Elegir foto", message: "Qué título tiene esta foto?", preferredStyle: .alert)
            ac.addTextField(configurationHandler: { (textField) in
                textField.placeholder = "prueba"
            })
            let a1 = UIAlertAction(title: "Ok", style: .default) { (alert) in
                let txtTitulo = ac.textFields?.first
                self.imageName = txtTitulo?.text ?? "myImage"
                let ac2 = UIAlertController(title: "My Images", message: "Ahora puedes dibujar sobre tu foto", preferredStyle: .alert)
                let ok = UIAlertAction(title: "Ok", style: .default) { (action) in
                    self.up_button.isHidden = false
                }
                ac2.addAction(ok)
                self.present(ac2, animated: true, completion:nil)
            }
            ac.addAction(a1)
            ipc.dismiss(animated: true) {
                self.present(ac, animated:true, completion:nil)
            }
        }
        else {
            ipc.dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        ipc.dismiss(animated: true, completion: nil)
    }
    
}


//
//  ViewController.swift
//  Downloader
//
//  Created by Jan Zelaznog on 23/11/17.
//  Copyright © 2017 Jan Zelaznog. All rights reserved.
//

import UIKit

class ViewController: UIViewController, URLSessionDelegate, URLSessionDownloadDelegate {
    var urlString:String = ""
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var conn:URLSession?
    var data:Data?
    func guardarImagen() {
        if let image = UIImage(data:self.data!) {
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(savedImage), nil)
        }
    }
    @objc func savedImage(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafeRawPointer) {
        if error != nil {
            print ("ocurrió un error al guardar la imagen")
        }
        else {
            print ("la imagen ya se guardó")
        }
    }
    func guardarArchivo() {
        //obtener la ubicacion de Documents
        let docsPath = FileManager.default.urls(for:.documentDirectory, in:.userDomainMask)[0]
        // obtener el nombre del archivo a partir de la URL de descarga
        let urlTMP = URL(string:urlString)
        let fileName = urlTMP?.lastPathComponent
        let imagePath = docsPath.appendingPathComponent(fileName!)
        print (imagePath)
        // guardar el arreglo de bytes como el tipo de archivo correspondiente
        do {
            try self.data?.write(to:imagePath)
        }
        catch {
            print ("Error al guardar el archivo " + error.localizedDescription)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let config = URLSessionConfiguration.background(withIdentifier: "\(Bundle.main.bundleIdentifier!).background")
        conn = URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue())
        urlString = "http://chandra.harvard.edu/photo/2014/15year/crab.jpg"
        if let url = URL(string:urlString) {
            let task = conn!.downloadTask(with: url)
            task.resume()
        }
    }
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        if totalBytesExpectedToWrite > 0 {
            let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
            debugPrint("Progress \(downloadTask) \(progress)")
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        debugPrint("Download finished: \(location)")
        do {
            data = try Data(contentsOf: location)
            guardarImagen()
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: self.data!)
                self.activityIndicator.stopAnimating()
            }
        } catch {
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if error != nil {
            debugPrint("error: "+error!.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


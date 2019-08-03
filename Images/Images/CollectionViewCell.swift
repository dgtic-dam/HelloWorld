//
//  CollectionViewCell.swift
//  Images
//
//  Created by Infraestructura on 8/3/19.
//  Copyright © 2019 Daniel Rosales. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var Image: UIImageView!
    
    @IBOutlet weak var txtLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configurarCelda(_ info:Imagen){

        if let imgNom = info.path as? String{
            let libraryURL = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)
           // let urlFoto = libraryURL.appendingPathComponent(imgNom)
            print ("Imprime url de imagen: \(imgNom)")
            let URLStr = "File:" + imgNom
            print("Imprime imagen: \(URLStr)")
            Image.image = UIImage(named: URLStr)
            /*if let url = U=RL(string: URLStr){
                do {
                    let bytes = try Data(contentsOf: url) // la clase Data representa un arreglo de bytes
                    // let iv = UIImageView(frame: UIScreen.main.bounds)
                    //  iv.contentMode = .scaleAspectFit //Para que la imagen no se estire ni se pierda la resolución
                    //  self.view.addSubview(iv)
                    //Se crea un objeto UImage a partir  de los bytes obtenidos de la URL
                    //   iv.image = UIImage(data: bytes)
                    datailImage.contentMode = .scaleAspectFit
                    datailImage.image = UIImage(data: bytes)
                }
                catch {
                    let imageEmpty = "empty_250.png"
                    datailImage.image = UIImage(named: imageEmpty)
                    print ("No existe la imagen " + error.localizedDescription)
                }*/
        }
        if let txtNom = info.titulo as? String {
            txtLabel.text = txtNom
           print ("Imprime label de Celda: \(txtNom)")
        }
    }
}

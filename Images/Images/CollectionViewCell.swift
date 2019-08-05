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
            let libraryURL = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first
            if let urlFoto = libraryURL?.appendingPathComponent(imgNom){
                if let bytes = try? Data(contentsOf: urlFoto) {
                    Image.image = UIImage(data: bytes)
                }
            }
        }
            
            
    
           // let URLStr = "File:" + imgNom
            //print("Imprime imagen: \(URLStr)")
           // let url = URL(string: stringFoto!)
            //// la clase Data representa un arreglo de bytes
            
    
        if let txtNom = info.titulo as? String {
            txtLabel.text = txtNom
           print ("Imprime label de Celda: \(txtNom)")
        }
    }
}

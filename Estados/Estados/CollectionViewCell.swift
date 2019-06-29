//
//  CollectionViewCell.swift
//  Estados
//
//  Created by Infraestructura on 6/28/19.
//  Copyright © 2019 Dan Ros. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var entidad: UILabel!
    
    @IBOutlet weak var capital: UILabel!
    
    @IBOutlet weak var escudo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //_ omite la primera etiqueta en el paso de parámetros
    
    func configuraCelda(_ info:[String:Any?]){
        
        if let edoNom = info["entidad"] as? String {
            entidad.text = edoNom
        }
        if let imgNom = info["imagen"] as? String{
            escudo.image = UIImage(named: imgNom)
        }
        if let capNom = info["capital"] as? String {
            capital.text = capNom
        }
    }

    /*override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
     }*/
    
}

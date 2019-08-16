//
//  MyTableViewCell.swift
//  NotiAndProtocols
//
//  Created by Infraestructura on 8/16/19.
//  Copyright © 2019 Daniel Rosales. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    
    private let boton = UIButton()
    private var bookName = ""
    
    //Se sobreescribe init porque no tenemos un XIB queutilice el awakeFromNib
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.white
        // Crear los objetos que va a tener la celda
        self.boton.setTitle("COMPRAR", for: .normal)
        self.boton.setTitleColor(UIColor.red, for: .normal)
        self.boton.backgroundColor = UIColor.yellow
        self.boton.addTarget(self, action: #selector(botonTouch), for: .touchUpInside)
        self.addSubview(boton)
    }
    
    @objc func botonTouch(){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "botonTouch"), object: self, userInfo: ["book":bookName]) // Se genera notificación 
    }
    
    func configure(book:String){
        self.boton.setTitle("COMPRAR \(book)", for: .normal)
        self.boton.frame = CGRect(x: 10, y: 0, width: self.frame.width - 50, height: self.frame.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

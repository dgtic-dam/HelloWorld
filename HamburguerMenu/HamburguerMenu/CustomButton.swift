//
//  CustomButton.swift
//  HamburguerMenu
//
//  Created by Infraestructura on 6/22/19.
//  Copyright © 2019 Dan Ros. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    */
   // override func draw(_ rect: CGRect) { &//instancia con código
   //     super.draw(rect)
        //994fb6
        
        required init?(coder aDecoder:NSCoder){
            super.init(coder: aDecoder)
      //  let miColor = UIColor(red: 153.0/255.0, green: 79.0/255.0, blue: 182.0/255.0, alpha: 0.0)
        layer.borderWidth = 3.0
        //layer.backgroundColor = UIColor.clear.cgColor //Transparent
        layer.backgroundColor = Utils.mainColor.cgColor
        layer.borderColor = UIColor.white.cgColor
        layer.cornerRadius = 15.0
        setTitleColor(UIColor.white, for: .normal)
        //titleLabel?.font = Utils.mainFont
        
    }


}

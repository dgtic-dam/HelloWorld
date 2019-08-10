//
//  ScrollViewController.swift
//  CandySearch
//
//  Created by Jan Zelaznog on 16/06/18.
//  Copyright © 2018 Peartree Developers. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController {
    var tecladoArriba = false
    var scrollView:UIScrollView?
    var txtNom:UITextField?
    var txtApp:UITextField?
    var txtMail:UITextField?
    var txtMail2:UITextField?
    var txtPhone: UITextField!
    
    ///// Dimensions
    let SCREEN_WIDTH:CGFloat = UIScreen.main.bounds.width
    let SCREEN_HEIGHT:CGFloat = UIScreen.main.bounds.height
    let kSeparator:CGFloat = 15.0
    let kLabelHeight:CGFloat = 30.0
    let kTextFieldHeight:CGFloat = 40.0
    var kTextFieldWidth:CGFloat = 0.0
    ////// Fonts
    let REG_FONT = UIFont(name:"Avenir", size:14.0)
    let TITLE_FONT = UIFont(name:"Avenir-Bold", size:18.0)
    ////// Colors
    let txtBackColor = UIColor.black
    let txtForeColor = UIColor.lightGray
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kTextFieldWidth = (self.SCREEN_WIDTH - (self.kSeparator * 2))
        self.buildUX()
        
    }
    override func viewWillDisappear(_ animated:Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidAppear(_ animated:Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector:#selector(tecladoAparece(_ :)), name:UIResponder.keyboardWillShowNotification, object:nil)
        NotificationCenter.default.addObserver(self, selector:#selector(tecladoDesaparece(_ :)), name:UIResponder.keyboardDidHideNotification, object:nil)
    }
    
    func buildUX() {
        self.scrollView = UIScrollView(frame:CGRect.init(x:0.0, y:20.0, width:SCREEN_WIDTH, height:SCREEN_HEIGHT))
        self.view.addSubview(self.scrollView!)
        var laY = kSeparator
        let lbl0 = UILabel(frame: CGRect.init(x:kSeparator, y:laY, width:kTextFieldWidth, height:kLabelHeight))
        lbl0.font = TITLE_FONT
        lbl0.text = "INFORMACION PERSONAL"
        self.scrollView!.addSubview(lbl0)
        laY += kLabelHeight + kSeparator
        let lbl1 = UILabel(frame: CGRect.init(x:kSeparator, y:laY, width:kTextFieldWidth, height:kLabelHeight))
        lbl1.font = REG_FONT
        lbl1.text = "Nombre (s)"
        self.scrollView!.addSubview(lbl1)
        laY += kLabelHeight + kSeparator
        self.txtNom = UITextField(frame: CGRect.init(x:kSeparator, y:laY, width:kTextFieldWidth, height:kTextFieldHeight))
        self.txtNom!.backgroundColor = txtBackColor
        self.txtNom!.textColor = txtForeColor
        self.scrollView!.addSubview(self.txtNom!)
        laY += kTextFieldHeight + kSeparator
        let lbl2 = UILabel(frame: CGRect.init(x:kSeparator, y:laY, width:kTextFieldWidth, height:kLabelHeight))
        lbl2.font = REG_FONT
        lbl2.text = "Apellido (s)"
        self.scrollView!.addSubview(lbl2)
        laY += kLabelHeight + kSeparator
        self.txtApp = UITextField(frame: CGRect.init(x:kSeparator, y:laY, width:kTextFieldWidth, height:kTextFieldHeight))
        self.txtApp!.backgroundColor = txtBackColor
        self.txtApp!.textColor = txtForeColor
        self.scrollView!.addSubview(self.txtApp!)
        laY += kTextFieldHeight + kSeparator
        let lbl3 = UILabel(frame: CGRect.init(x:kSeparator, y:laY, width:kTextFieldWidth, height:kLabelHeight))
        lbl3.font = REG_FONT
        lbl3.text = "Correo electrónico"
        self.scrollView!.addSubview(lbl3)
        laY += kLabelHeight + kSeparator
        self.txtMail = UITextField(frame: CGRect.init(x:kSeparator, y:laY, width:kTextFieldWidth, height:kTextFieldHeight))
        self.txtMail!.backgroundColor = txtBackColor
        self.txtMail!.textColor = txtForeColor
        self.txtMail!.keyboardType = .emailAddress
        self.txtMail!.autocapitalizationType = UITextAutocapitalizationType.none
        self.txtMail!.autocorrectionType = .no
        self.scrollView!.addSubview(self.txtMail!)
        laY += kTextFieldHeight + kSeparator
        let lbl4 = UILabel(frame: CGRect.init(x:kSeparator, y:laY, width:kTextFieldWidth, height:kLabelHeight))
        lbl4.font = REG_FONT
        lbl4.text = "Confirme su correo"
        self.scrollView!.addSubview(lbl4)
        laY += kLabelHeight + kSeparator
        self.txtMail2 = UITextField(frame: CGRect.init(x:kSeparator, y:laY, width:kTextFieldWidth, height:kTextFieldHeight))
        self.txtMail2!.backgroundColor = txtBackColor
        self.txtMail2!.textColor = txtForeColor
        self.txtMail2!.keyboardType = .emailAddress
        self.txtMail2!.autocapitalizationType = UITextAutocapitalizationType.none
        self.txtMail2!.autocorrectionType = .no
        self.scrollView!.addSubview(self.txtMail2!)
        laY += kTextFieldHeight + kSeparator
        let lbl5 = UILabel(frame: CGRect.init(x:kSeparator, y:laY, width:kTextFieldWidth, height:kLabelHeight))
        lbl5.font = REG_FONT
        lbl5.text = "Teléfono"
        self.scrollView!.addSubview(lbl5)
        laY += kLabelHeight + kSeparator
        self.txtPhone = UITextField(frame: CGRect.init(x:kSeparator, y:laY, width:kTextFieldWidth, height:kTextFieldHeight))
        self.txtPhone!.backgroundColor = txtBackColor
        self.txtPhone!.textColor = txtForeColor
        self.scrollView!.addSubview(self.txtPhone!)
        // esto cancela la función de scroll
       // self.scrollView!.contentSize = (scrollView?.frame.size)!
        self.scrollView!.contentSize = CGSize(width: (scrollView?.frame.width)!, height: self.txtPhone.frame.maxY)
        let tap = UITapGestureRecognizer(target: self, action:#selector(tapped)) //
        self.scrollView!.addGestureRecognizer(tap)
    }
    
    @objc func tapped() {
        self.resignFields()
    }
    
    func resignFields() {
        self.view.endEditing(true)
        /*
        self.txtApp?.resignFirstResponder()
        self.txtNom?.resignFirstResponder()
        self.txtMail?.resignFirstResponder()
        self.txtMail2?.resignFirstResponder()
        self.txtPhone?.resignFirstResponder()
        */
    }
    
    @objc func tecladoAparece(_ notification:Notification){
        if self.tecladoArriba {
            return
        }
        self.adjustUI(notification, up:true)
    }
    
    @objc func tecladoDesaparece(_ notification:Notification){
        self.adjustUI(notification, up:false)
    }
    
    func adjustUI(_ notification:Notification, up:Bool) {
        let info:Dictionary = notification.userInfo!
        let value = info [UIResponder.keyboardFrameEndUserInfoKey] as! NSValue //Pregunta cuando mide el teclado cuando se terminó de mover
        let frameTeclado = value.cgRectValue
        var contentSize = self.scrollView!.contentSize
        if up {
            contentSize.height += frameTeclado.size.height;
        }
        else {
            contentSize.height -= frameTeclado.size.height;
        }
        self.scrollView!.contentSize = contentSize;
        self.tecladoArriba = up
    }
        
    
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            
            //MARK:- If Delete button click
            let  char = string.cString(using: String.Encoding.utf8)!
            let isBackSpace = strcmp(char, "\\b")
            
            if (isBackSpace == -92) {
                textField.text!.removeLast()
                return false
            }
            
            if textField == txtPhone
            {
                if (textField.text?.count)! == 2
                {
                    textField.text = "(\(textField.text!)) "  //There we are ading () and space two things
                }
                else if (textField.text?.count)! == 9
                {
                    textField.text = "\(textField.text!)-" //there we are ading - in textfield
                }
                else if (textField.text?.count)! > 13
                {
                    return false
                }
            }
            return true
        }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

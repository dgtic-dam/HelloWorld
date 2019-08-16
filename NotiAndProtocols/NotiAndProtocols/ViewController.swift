//
//  ViewController.swift
//  NotiAndProtocols
//
//  Created by Infraestructura on 8/16/19.
//  Copyright © 2019 Daniel Rosales. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let identificador = "myCell"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identificador, for: indexPath) as! MyTableViewCell
        cell.configure(book: books[indexPath.row])
        return cell
    }
    
    //Si el usuario toca la celda
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bookName = books[indexPath.row].replacingOccurrences(of: " ", with: "_")
        let urlStr = "https://google.com/search?q=" + bookName
        UIApplication.shared.open(URL(string: urlStr)!, options: [:], completionHandler: nil)

    }
    
    let books = ["Mujercitas", "Orgullo y Prejuicio", "Bovedas de Acero", "El viaje del Elefante", "El Padrino", "El Extranjero", "Become an Xcoder"]
    let tabla = UITableView()
    
    override func viewWillAppear(_ animated: Bool) { // Agregar el observador para el NotificationCenter
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(botonTouched), name: NSNotification.Name(rawValue: "botonTouch"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) { // Remover el observador del Notification Center
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func botonTouched(_ noti:Notification){
        if let userInfo = noti.userInfo{
            if let bookName = userInfo["book"] as? String{
                let ac = UIAlertController(title: "Libros", message: "Seguro que deseas comprar" + bookName, preferredStyle: .alert)
                let a1 = UIAlertAction(title: "SI", style: .default, handler: nil)
                let a2 = UIAlertAction(title: "NO", style: .destructive, handler: nil)
                ac.addAction(a1)
                ac.addAction(a2)
                self.present(ac, animated: true, completion: nil)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tabla.delegate = self
        tabla.dataSource = self
        tabla.register(MyTableViewCell.self, forCellReuseIdentifier: identificador)
        self.view.addSubview(tabla)
    }
    
    override func viewWillLayoutSubviews() {
        tabla.frame = self.view.frame.insetBy(dx: 50, dy: 50) //reducido en 50px en horizontal y 50 px en verticla
    }
}


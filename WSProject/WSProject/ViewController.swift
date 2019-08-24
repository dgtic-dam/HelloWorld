//
//  ViewController.swift
//  WSProject
//
//  Created by Rafael González on 8/17/19.
//  Copyright © 2019 com.gonzalez.rafael. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    let username = "projectManagementWS"
    let password = "pr0j3ctM4n4g3m3ntWS"
    let baseURL = "http://localhost:8080/ws/services/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //GET All
    @IBAction func btnGetAll(_ sender: UIButton) {
        
        let loginData = String(format: "%@:%@", username, password).data(using: String.Encoding.utf8)!
        let base64LoginData = loginData.base64EncodedString()
        
        //Create the request
        let url = URL(string: baseURL + "projectmananger/projectmanangers/" )!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Basic \(base64LoginData)", forHTTPHeaderField: "Authorization")
        
        //Making the request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse {
                // Check status code returned by the http server
                print("Status Code : \(httpStatus.statusCode)")
                print("Data :  \(data)")
                print(String(data: data, encoding: .utf8)!)
            }
        }
        task.resume()
    }
    
    //GET
    @IBAction func btnGetById(_ sender: UIButton) {
        
        let loginData = String(format: "%@:%@", username, password).data(using: String.Encoding.utf8)!
        let base64LoginData = loginData.base64EncodedString()
        
        //Create the request
        let url = URL(string: baseURL + "projectmananger/projectmananger/1" )!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Basic \(base64LoginData)", forHTTPHeaderField: "Authorization")
        
        //Making the request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse {
                // Check status code returned by the http server
                print("Status Code : \(httpStatus.statusCode)")
                print("Data :  \(data)")
                print(String(data: data, encoding: .utf8)!)
            }
        }
        task.resume()
    }
    
    
    //POST
    @IBAction func btnPost(_ sender: UIButton) {
        
        let loginData = String(format: "%@:%@", username, password).data(using: String.Encoding.utf8)!
        let base64LoginData = loginData.base64EncodedString()
        
        //Create the request
        let url = URL(string: baseURL + "projectmananger/projectmananger/" )!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Basic \(base64LoginData)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept" )
        request.setValue("application/json", forHTTPHeaderField: "Content-Type" )
        //Create JSON
        let firstName = "Juan"
        let lastName = "Pérez"
        
        let jsonObject: [String:Any] = [
                "firstName": firstName,
                "lastName": lastName
        ]
        if let data = try? JSONSerialization.data(withJSONObject: jsonObject, options: [] ),
            let jsonString = String(data: data, encoding: .utf8) {
            //Insert json data to the request
            request.httpBody = jsonString.data(using: .utf8)
        }
        
        //Making the request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse {
                // Check status code returned by the http server
                print("Status Code : \(httpStatus.statusCode)")
                print("Data :  \(data)")
                print(String(data: data, encoding: .utf8)!)
            }
        }
        task.resume()
        
    }
    //PUT
    
    @IBAction func btnPut(_ sender: UIButton) {
        let loginData = String(format: "%@:%@", username, password).data(using: String.Encoding.utf8)!
        let base64LoginData = loginData.base64EncodedString()
        
        //Create the request
        let url = URL(string: baseURL + "projectmananger/projectmananger/" )!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("Basic \(base64LoginData)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept" )
        request.setValue("application/json", forHTTPHeaderField: "Content-Type" )
        //Create JSON
        let id = 10
        let firstName = "Susana"
        let lastName = "Pérez"
        
        let jsonObject: [String:Any] = [
            "id":id,
            "firstName": firstName,
            "lastName": lastName
        ]
        if let data = try? JSONSerialization.data(withJSONObject: jsonObject, options: [] ),
            let jsonString = String(data: data, encoding: .utf8) {
            //Insert json data to the request
            request.httpBody = jsonString.data(using: .utf8)
        }
        
        //Making the request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse {
                // Check status code returned by the http server
                print("Status Code : \(httpStatus.statusCode)")
                print("Data :  \(data)")
                print(String(data: data, encoding: .utf8)!)
            }
        }
        task.resume()
    }
    
    
    //DELETE
    @IBAction func btnDelete(_ sender: UIButton) {
        let loginData = String(format: "%@:%@", username, password).data(using: String.Encoding.utf8)!
        let base64LoginData = loginData.base64EncodedString()
        
        //Create the request
        let url = URL(string: baseURL + "projectmananger/projectmananger/10" )!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("Basic \(base64LoginData)", forHTTPHeaderField: "Authorization")
        
        //Making the request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse {
                // Check status code returned by the http server
                print("Status Code : \(httpStatus.statusCode)")
                print("Data :  \(data)")
                print(String(data: data, encoding: .utf8)!)
            }
        }
        task.resume()
    }
}


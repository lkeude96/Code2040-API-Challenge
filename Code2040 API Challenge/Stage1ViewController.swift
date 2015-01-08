//
//  Stage1ViewController.swift
//  Code2040 API Challenge
//
//  Created by Eude Kinsley Lesperance on 1/5/15.
//  Copyright (c) 2015 Qlovur. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Stage1ViewController: UIViewController {
    

    @IBOutlet weak var initialStringLabel: UILabel!
    @IBOutlet weak var reversedStringLabel: UILabel!
    var tokenStr: String?
    let commonURL = "http://challenge.code2040.org/api"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let url = "\(self.commonURL)/register"
        
        let email: String = "l.keude96@gmail.com"
        let github: String = "https://github.com/lkeude96/Code2040-API-Challenge"
        let registrationInfo = [
            "email": email,
            "github": github
            ] as Dictionary
        
        
        Alamofire.request(.POST, url, parameters: registrationInfo, encoding: .JSON)
            .responseJSON { (request, response, json, error) in
                if(error != nil) {
                    println("Error: \(error)")
                    println(request)
                    println(response)
                }
                else {
                    println("Success: \(url)")
                    println(request)
                    var json = JSON(json!)
                    if let data = json["result"].stringValue as String? {
                        println(data)
                    }
                }
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    
    @IBAction func fetchStringButton(sender: UIButton) {
        let url = "\(self.commonURL)/getstring"
        
        let token = [
            "token": "YwUoY4pc6I"
            ] as Dictionary
        
        
        Alamofire.request(.POST, url, parameters: token, encoding: .JSON)
            .responseJSON { (request, response, json, error) in
                if(error != nil) {
                    println("Error: \(error)")
                    println(request)
                    println(response)
                }
                else {
                    println("Success: \(url)")
                    println(request)
                    var json = JSON(json!)
                    if let data = json["result"].stringValue as String? {
                        self.initialStringLabel.text = data
                        println(data)
                        self.reversedStringLabel.text = self.reverseString(data)
                        println(self.reverseString(data))
                        
                        var validateDict = [
                            "token": "YwUoY4pc6I",
                            "string": "\(self.reverseString(data))"
                            ] as Dictionary
                        
                        Alamofire.request(.POST, "\(self.commonURL)/validatestring", parameters: validateDict, encoding: .JSON)
                            .responseJSON { (request, response, json, error) in
                                if(error != nil) {
                                    println("Error: \(error)")
                                    println(request)
                                    println(response)
                                }
                                else {
                                    println("Success: \(url)")
                                    println(request)
                                    var json = JSON(json!)
                                    if let data = json["result"].stringValue as String? {
                                        println(data)
                                    }
                                }
                        }
                        
                        
                        
                    
                    }
                }
        }

        
    }

    @IBAction func reverseStringButton(sender: UIButton) {
        
    }
    
    @IBAction func submit(sender: UIButton) {
        
    }
    
    
    func reverseString(str: String) -> String {
        
        return String(reverse(str))
    }
}

//
//  Stage3ViewController.swift
//  Code2040 API Challenge
//
//  Created by Eude Kinsley Lesperance on 1/8/15.
//  Copyright (c) 2015 Qlovur. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Stage3ViewController: UIViewController {
    let commonURL = "http://challenge.code2040.org/api"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        let urlForPrefix = "\(self.commonURL)/prefix"
        
        let token = [
            "token": "YwUoY4pc6I"
            ] as Dictionary
        
        
        Alamofire.request(.POST, urlForPrefix, parameters: token, encoding: .JSON)
            .responseJSON { (request, response, json, error) in
                if(error != nil) {
                    println("Error: \(error)")
                    println(request)
                    println(response)
                }
                else {
                    println("Success: \(urlForPrefix)")
                    println(request)
                    var json = JSON(json!)
                    if let data = json["result"] as JSON?{
                        var dataArray = data["array"]
                        println(dataArray)
                        var prefix = data["prefix"].stringValue as String?
                        println(prefix)
                        
                        var matchedArray: Array<String> = []
                        
                        
                        
                        for var i = 0; i < dataArray.count; i++ {
                            if (!(dataArray[i].stringValue as String).hasPrefix(prefix!)) {
                                matchedArray.append(dataArray[i].stringValue as String)
                                
                            }
                        }
                        
                        //var arr = matchedArray as Array<>
                        println(matchedArray)
                        
                        
                        let urlForValidatePrefix = "\(self.commonURL)/validateprefix"
                        var validateDict:Dictionary = ["token": "YwUoY4pc6I", "array": matchedArray] as Dictionary<String, AnyObject>
                        
                        
                        Alamofire.request(.POST, urlForValidatePrefix, parameters: validateDict,encoding:.JSON).responseJSON {
                            (request, response, json, error) in
                            if(error != nil) {
                                println("Error: \(error)")
                                println(request)
                                println(response)
                            }
                            else {
                                println("Success: \(urlForValidatePrefix)")
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

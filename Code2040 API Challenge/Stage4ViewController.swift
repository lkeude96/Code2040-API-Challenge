//
//  Stage4ViewController.swift
//  Code2040 API Challenge
//
//  Created by Eude Kinsley Lesperance on 1/8/15.
//  Copyright (c) 2015 Qlovur. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Stage4ViewController: UIViewController {
    let commonURL = "http://challenge.code2040.org/api"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let urlForTime = "\(self.commonURL)/time"
        
        let token = [
            "token": "YwUoY4pc6I"
            ] as Dictionary
        
        
        Alamofire.request(.POST, urlForTime, parameters: token, encoding: .JSON)
            .responseJSON { (request, response, json, error) in
                if(error != nil) {
                    println("Error: \(error)")
                    println(request)
                    println(response)
                }
                else {
                    println("Success: \(urlForTime)")
                    println(request)
                    var json = JSON(json!)
                    if let data = json["result"] as JSON?{
                        var dateStamp = data["datestamp"].stringValue as String
                        println(dateStamp)
                        var interval = data["interval"].doubleValue as NSTimeInterval
                        println(interval)
                        
                        let dateFormat = NSDateFormatter()
                            dateFormat.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSS'Z'"
                        
                        let dateStampFormatted = dateFormat.dateFromString(dateStamp)
                        
                        let dateStampWithInterval = dateStampFormatted?.dateByAddingTimeInterval(interval)
                        
                        let newDateStamp = dateFormat.stringFromDate(dateStampWithInterval!)
                        
                        println(newDateStamp)
                        
                        let urlForValidateTime = "\(self.commonURL)/validatetime"
                        let validateDict: Dictionary = ["token": "YwUoY4pc6I","datestamp": newDateStamp ] as Dictionary
                        
                        
                        Alamofire.request(.POST, urlForValidateTime, parameters: validateDict,encoding:.JSON).responseJSON {
                            (request, response, json, error) in
                            if(error != nil) {
                                println("Error: \(error)")
                                println(request)
                                println(response)
                            }
                            else {
                                println("Success: \(urlForValidateTime)")
                                println(request)
                                var json = JSON(json!)
                                //if let data = json["result"].stringValue as String? {
                                    println(json)
                                //}
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

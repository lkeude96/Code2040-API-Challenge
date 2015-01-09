//
//  Stage2ViewController.swift
//  Code2040 API Challenge
//
//  Created by Eude Kinsley Lesperance on 1/5/15.
//  Copyright (c) 2015 Qlovur. All rights reserved.
//

import UIKit
import AlamoFire
import SwiftyJSON

class Stage2ViewController: UIViewController {
    
    @IBOutlet weak var needleLabel: UILabel!
    @IBOutlet weak var haystackLabel: UILabel!
    @IBOutlet weak var needleIndexLabel: UILabel!
    let commonURL = "http://challenge.code2040.org/api"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlForHaystack = "\(self.commonURL)/haystack"
        
        let token = [
            "token": "YwUoY4pc6I"
            ] as Dictionary
        
        
        Alamofire.request(.POST, urlForHaystack, parameters: token, encoding: .JSON)
            .responseJSON { (request, response, json, error) in
                if(error != nil) {
                    println("Error: \(error)")
                    println(request)
                    println(response)
                }
                else {
                    println("Success: \(urlForHaystack)")
                    println(request)
                    var json = JSON(json!)
                    if let data = json["result"] as JSON?{
                        var haystack = data["haystack"].arrayValue as Array
                        println(haystack)
                        var needle = data["needle"].stringValue as String?
                        println(needle)
                        
                        var needleIndex = 0
                        
                        while(haystack[needleIndex].stringValue as String != needle){
                            needleIndex++
                        }
                        
                        let validateDict = [
                            "token": "YwUoY4pc6I",
                            "needle": "\(needleIndex)"
                            ] as Dictionary
                        
                        let urlForValidateNeedle = "\(self.commonURL)/validateneedle"
                        
                        Alamofire.request(.POST, urlForValidateNeedle, parameters: validateDict, encoding: .JSON)
                            .responseJSON { (request, response, json, error) in
                                if(error != nil) {
                                    println("Error: \(error)")
                                    println(request)
                                    println(response)
                                }
                                else {
                                    println("Success: \(urlForValidateNeedle)")
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
    

    @IBAction func fetchDataButton(sender: UIButton) {
    }
    
    @IBAction func findNeedleButton(sender: UIButton) {
    }

    @IBAction func submitButton(sender: UIButton) {
    }
}

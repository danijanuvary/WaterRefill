//
//  ViewController.swift
//  WaterRefill
//
//  Created by Jithin on 20/01/20.
//  Copyright © 2020 FabCoders. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let params:[String:String] = ["X_API_KEY":"FABFabCodersENCRY", "range":"10","currentlatitude":"12.98582","currentlongitude":"77.605522","order_by":"refill_id DESC","limit":"1000","offset":"0"]
        
        GetRefillPoints(params).loadRefillPoints { (points) in
            NSLog("Here")
        }
        
    }


}


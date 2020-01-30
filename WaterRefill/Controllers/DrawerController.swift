//
//  DrawerController.swift
//  WaterRefill
//
//  Created by Jithin on 29/01/20.
//  Copyright © 2020 FabCoders. All rights reserved.
//

import UIKit
import KYDrawerController

class DrawerController: KYDrawerController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let navigationController = self.mainViewController as? UINavigationController{
            if let mainController = navigationController.viewControllers.first as? InitialViewController, let drawerViewController = self.drawerViewController as? DrawerViewController{
                    drawerViewController.delegate = mainController
            }
        }
    }
    
    

}

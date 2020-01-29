//
//  SplashScreen.swift
//  WaterRefill
//
//  Created by Jithin on 21/01/20.
//  Copyright © 2020 FabCoders. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       // perform(#selector(SplashViewController.showInitialView), with: nil, afterDelay: 1)
        perform(#selector(SplashViewController.showInitialView), with: nil, afterDelay: 0)
    }
    
    @objc func showInitialView(){
        let transition = CATransition()
       // transition.duration = 0.6
        transition.duration = 0.0
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        
        let appDelegate = AppDelegate.sharedInstance()
        appDelegate.window?.rootViewController = appDelegate.getMainController()
    }
    

}

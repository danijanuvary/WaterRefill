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
        perform(#selector(SplashViewController.showInitialView), with: nil, afterDelay: 2)
    }
    
    @objc func showInitialView(){
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        performSegue(withIdentifier: "showInitialScreen", sender: self)
    }
    

}

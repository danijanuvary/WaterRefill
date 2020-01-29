//
//  AppDelegate.swift
//  WaterRefill
//
//  Created by Jithin on 20/01/20.
//  Copyright © 2020 FabCoders. All rights reserved.
//

import UIKit
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let GOOGLE_MAP_SERVICES_API_KEY = "AIzaSyBlTH581V8u9IoPRwymP6ArWTXgzWLYyyM";
    
    var window: UIWindow?    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GMSServices.provideAPIKey(GOOGLE_MAP_SERVICES_API_KEY)
        //GMSPlacesClient.provideAPIKey(GOOGLE_MAP_SERVICES_API_KEY)
        return true
    }
    
    func getMainController() -> UIViewController{
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "mainNavigation")
        return initialViewController
    }
    
    class func sharedInstance() -> AppDelegate{
        return UIApplication.shared.delegate as! AppDelegate
    }
    
}


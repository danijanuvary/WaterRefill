//
//  InitialViewController.swift
//  WaterRefill
//
//  Created by Jithin on 21/01/20.
//  Copyright © 2020 FabCoders. All rights reserved.
//

import UIKit
import GoogleMaps
import iOSDropDown

class InitialViewController: UIViewController,GMSMapViewDelegate,CLLocationManagerDelegate {

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var dropDownMenu: DropDown!
    var locationManager = CLLocationManager()
    var myLocation:CLLocation!
    
    var initialLoad:Bool!
    let ranges = [1,5,10,20,50,100,40000]
    let rangeDescription = ["1 km","5 km","10 km","20 km","50 km","100 km","100+ km"]
    let defaultRange = 1000

    var refillPoints:[RefillPoint]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationLogo()
        setDropDownMenu()
       // setMapView()
        initialLoad = true
    }
    
    func setNavigationLogo(){
        let image: UIImage = UIImage(named: "logotext.png")!
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        self.navigationItem.titleView = imageView
        navigationController?.navigationBar.barTintColor = UIColor.systemBlue
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    func setMapView(){
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    func setDropDownMenu(){
        dropDownMenu.optionArray = rangeDescription
        dropDownMenu.optionIds = ranges
        dropDownMenu.isSearchEnable = false
        dropDownMenu.selectedIndex = 2
        dropDownMenu.text = rangeDescription[dropDownMenu.selectedIndex!]
        dropDownMenu.didSelect { (selectedText, index, id) in
            self.dropDownMenu.selectedIndex = index
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            let camera = GMSCameraPosition.camera(withLatitude: (location.coordinate.latitude), longitude:(location.coordinate.longitude), zoom:14)
            mapView.animate(to: camera)
            locationManager.stopUpdatingLocation()
            getAllRefillPoints()
        }
    }
    
    func getAllRefillPoints(){
        guard let myLocation = mapView.myLocation else {
            return
        }
        let range:Int = defaultRange
        var params:[String:String] = [:]
        params[Constants.KEY_API] = Constants.FABCODERS_API_KEY
        params[Constants.KEY_RANGE] = String(range)
        params[Constants.KEY_LATITUDE] = String(myLocation.coordinate.latitude)
        params[Constants.KEY_LONGITUDE] = String(myLocation.coordinate.longitude)
        params[Constants.KEY_ORDER_BY] = "refill_id DESC"
        params[Constants.KEY_LIMIT] = "1000"
        params[Constants.KEY_OFFSET] = "0"
        GetRefillPoints(params).loadRefillPoints { (points) in
            self.refillPoints = points
        }
    }
}

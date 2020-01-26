//
//  InitialViewController.swift
//  WaterRefill
//
//  Created by Jithin on 21/01/20.
//  Copyright © 2020 FabCoders. All rights reserved.
//

import UIKit
import GoogleMaps
import DropDown

class InitialViewController: UIViewController,GMSMapViewDelegate,CLLocationManagerDelegate{

    let REFILL_POINT_CELL_NIB = "RefillPointCell"
    let identifier  = "RefillPointCell"
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noRefillPointsView: UIView!
    @IBOutlet weak var showRefillPointsView: UIView!
    @IBOutlet weak var rootStackView: UIStackView!
    
    @IBOutlet weak var selectRangeOption: UIButton!
    
    var locationManager = CLLocationManager()
    var myLocation:CLLocation!
    var dropDownMenu:DropDown!
    var initialLoad:Bool!
    let ranges = [1,5,10,20,50,100,40000]
    let rangeDescription = ["1 km","5 km","10 km","20 km","50 km","100 km","100+ km"]
    let defaultRange = 10
    var refillPoints:[RefillPoint] = [RefillPoint]()
    var markers:[GMSMarker] = [GMSMarker]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationLogo()
        setDropDownMenu()
        setMapView()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.showRefillPoints(_:)))
        showRefillPointsView.addGestureRecognizer(tap)
        tableView.register(UINib.init(nibName: REFILL_POINT_CELL_NIB, bundle: nil), forCellReuseIdentifier: identifier)
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
        dropDownMenu = DropDown()
        dropDownMenu.anchorView = selectRangeOption
        dropDownMenu.dataSource = rangeDescription
        dropDownMenu.bottomOffset = CGPoint(x: 0, y: selectRangeOption.bounds.height)
        dropDownMenu.width = 150
        
        dropDownMenu.selectionAction = { [unowned self] (index: Int, item: String) in
            self.getAllRefillPoints(range: self.ranges[index])
            self.selectRangeOption.setTitle(self.rangeDescription[index], for: .normal)
        }
        
        
    }
    @IBAction func rangeButtonSelected(_ sender: Any) {
        dropDownMenu.show()
    }
    
    func mapViewSnapshotReady(_ mapView: GMSMapView) {
        mapView.settings.scrollGestures = true
        mapView.settings.zoomGestures = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            let camera = GMSCameraPosition.camera(withLatitude: (location.coordinate.latitude), longitude:(location.coordinate.longitude), zoom:15)
            mapView.animate(to: camera)
            myLocation = location
            locationManager.stopUpdatingLocation()
            getAllRefillPoints(range: defaultRange)
        }
    }
    
    func getAllRefillPoints(range:Int){
        guard let myLocation = mapView.myLocation else {
            return
        }
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
            self.loadMapOverlays()
            self.tableView.reloadData()
            self.updateUI()
        }
    }
    
    func updateUI(){
        if refillPoints.count == 0{
            tableView.isHidden = true
            mapView.isHidden = false
            noRefillPointsView.isHidden = false
            showRefillPointsView.isHidden = true
        }
        else{
           noRefillPointsView.isHidden = true
           showRefillPointsView.isHidden = false
        }
    }
        
    @objc func showRefillPoints(_ sender: UITapGestureRecognizer? = nil) {
        
        if mapView.isHidden{
            let oldPoint = tableView.frame.origin
            UIView.animate(withDuration: 0.6, animations: {
                self.mapView.isHidden = false
                self.tableView.frame.origin.y = oldPoint.y + self.tableView.frame.size.height
            }) { (completion) in
              self.tableView.frame.origin = oldPoint
              self.tableView.isHidden = true
            }
        }
        else{
            let oldPoint = tableView.frame.origin
            tableView.frame.origin.y = tableView.frame.origin.y + tableView.frame.size.height
            UIView.animate(withDuration: 0.6, animations: {
                self.tableView.frame.origin = oldPoint
                self.tableView.isHidden = false
            }) { (completion) in
                self.mapView.isHidden = true
            }
        }
        
    }
    
    func loadMapOverlays(){
        
        mapView.clear()
        if refillPoints.count > 0{
            var bounds = GMSCoordinateBounds()
            for refillPoint in refillPoints{
                guard let latitude = Double(refillPoint.latitude) else { continue }
                guard let longitude = Double(refillPoint.longitude) else { continue }
                let position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                let marker = GMSMarker(position: position)
                marker.title = refillPoint.place_name
                marker.map = mapView
                bounds = bounds.includingCoordinate(marker.position)
                markers.append(marker)
            }
            mapView.animate(with: GMSCameraUpdate.fit(bounds, with: UIEdgeInsets(top: 50.0 , left: 50.0 ,bottom: 50.0 ,right: 50.0)))
        }
        else{
            
            guard let myLocation = mapView.myLocation else{return}
            let camera = GMSCameraPosition.camera(withLatitude: myLocation.coordinate.latitude, longitude:myLocation.coordinate.longitude, zoom:15)
            mapView.animate(to: camera)
        }
    }
    
    
}

extension InitialViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.refillPoints.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let refillPoint = refillPoints[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! RefillPointCell
        cell.setData(refillPoint: refillPoint)
        return cell
    }
    
}

extension InitialViewController:UITableViewDelegate{
    
}

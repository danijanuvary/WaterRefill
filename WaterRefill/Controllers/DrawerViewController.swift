//
//  DrawerViewController.swift
//  WaterRefill
//
//  Created by Jithin on 29/01/20.
//  Copyright © 2020 FabCoders. All rights reserved.
//

import UIKit

protocol DrawerSelectionDelegate {
    func itemSelected(row:Int)
}

class DrawerViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var delegate:DrawerSelectionDelegate? = nil
    
    var menuItems = ["Find a Water Refill Point","Add a Water Refill Point","Shop Bottles",
                     "Share-Spread the Word","Settings","About Us"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = menuItems[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.itemSelected(row: indexPath.row)
        
    }
    


}

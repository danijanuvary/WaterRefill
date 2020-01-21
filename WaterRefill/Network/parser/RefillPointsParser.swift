//
//  RefillPointsParser.swift
//  WaterRefill
//
//  Created by Jithin on 21/01/20.
//  Copyright © 2020 FabCoders. All rights reserved.
//

import UIKit
import SwiftyJSON

class RefillPointsParser: NSObject {
    
    static func parse(_ data:Data) -> [RefillPoint]{
        
        var refillPoints:[RefillPoint] = [];
        let json = JSON(data)
        let status = json["status"].boolValue
        let code = json["code"].intValue
        if(status && code == 200){
            let dataArray = json["data"].array
            guard let data = dataArray else {
                return refillPoints
            }
            for point in data {
                let refillPoint = parseRefillPoint(dict: point)
                refillPoints.append(refillPoint)
            }
        }
    
        return refillPoints
    }
    
    static func parseRefillPoint(dict:JSON) -> RefillPoint{
        
        let point = RefillPoint()
        point.refill_id = dict["refill_id"].intValue
        point.user_id = dict["user_id"].intValue
        point.place_name = dict["place_name"].stringValue
        point.contact_no = dict["contact_no"].stringValue
        point.address_1 = dict["address_1"].stringValue
        point.address_2 = dict["address_2"].stringValue
        point.country = dict["country"].stringValue
        point.state = dict["state"].stringValue
        point.city = dict["city"].stringValue
        point.zip_code = dict["zip_code"].stringValue
        point.source_of_drinking = dict["source_of_drinking"].stringValue
        point.last_serviced_date = dict["last_serviced_date"].stringValue
        point.ready = dict["ready"].boolValue
        point.free = dict["free"].boolValue
        point.more_about_yourself = dict["more_about_yourself"].stringValue
        point.latitude = dict["latitude"].stringValue
        point.longitude = dict["longitude"].stringValue
        point.opens_at = dict["opens_at"].stringValue
        point.closes_at = dict["closes_at"].stringValue
        point.thumbnail = dict["thumbnail"].stringValue
        point.created_on = dict["created_on"].stringValue
        point.refill_type = dict["refill_type"].intValue
        point.refillOrSeller = dict["refillOrSeller"].intValue
        point.isApproved = dict["isApproved"].boolValue
        point.rating = dict["rating"].stringValue
        
        return point
    }
}

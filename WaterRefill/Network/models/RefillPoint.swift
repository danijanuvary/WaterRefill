//
//  RefillPoint.swift
//  WaterRefill
//
//  Created by Jithin on 21/01/20.
//  Copyright © 2020 FabCoders. All rights reserved.
//

import UIKit

class RefillPoint: NSObject {
   var refill_id:Int = 0
   var user_id:Int = 0
   var place_name:String = ""
   var contact_no:String = ""
   var address_1:String = ""
   var address_2:String = ""
   var country:String = ""
   var state:String = ""
   var city:String = ""
   var zip_code:String = ""
   var source_of_drinking:String = ""
   var last_serviced_date:String = ""
   var ready:Bool = false
   var free:Bool = false
   var images:String = ""
   var more_about_yourself:String = ""
   var latitude:String = ""
   var longitude:String = ""
   var opens_at:String = ""
   var closes_at:String = ""
   var thumbnail:String = ""
   var created_on:String = ""
   var refill_type:Int = 0
   var refillOrSeller:Int = 0
   var isApproved:Bool = false
   var rating:String = ""
}

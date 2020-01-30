//
//  RefillPointCell.swift
//  WaterRefill
//
//  Created by Jithin on 23/01/20.
//  Copyright © 2020 FabCoders. All rights reserved.
//

import UIKit
import SDWebImage

class RefillPointCell: UITableViewCell {

    
    @IBOutlet weak var mainBackground: UIView!
    @IBOutlet weak var shadowLayer: UIView!
    
    @IBOutlet weak var refillImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        // Configure the view for the selected state
    }
    
    func setData(refillPoint:RefillPoint){
        
        mainBackground.layer.cornerRadius = 3
        mainBackground.layer.masksToBounds = true
        shadowLayer.layer.masksToBounds = false
        shadowLayer.layer.shadowOffset = CGSize(width: 0, height: 0)
        shadowLayer.layer.shadowColor = UIColor.black.cgColor
        shadowLayer.layer.shadowOpacity = 0.3
        shadowLayer.layer.cornerRadius = 3
        shadowLayer.layer.shadowRadius = 3
        
        refillImage.sd_imageTransition = .fade
        
        var thumbnailPath = refillPoint.thumbnail
        if thumbnailPath.first == "."{
            thumbnailPath.remove(at:thumbnailPath.startIndex)
        }
        
        let urlString = Constants.ROOT_URL + thumbnailPath
        let url = NSURL(string:urlString)
        refillImage.sd_setImage(with: url as URL?, placeholderImage: UIImage(named: "drop.png"))
        title.text = refillPoint.place_name
        subtitle.text = refillPoint.address_1 + " " + refillPoint.address_2
    }
}

//
//  DeliveriesCollectionViewCell.swift
//  Chocomarket(hackaton)
//
//  Created by Khaled on 01.05.2020.
//  Copyright © 2020 Khaled. All rights reserved.
//

import UIKit

class DeliveriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var deliveryNumber: UILabel!
    @IBOutlet weak var deliveryDescr: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var statusName: UILabel!
    
    func update(deliveryNumber: String, deliveryDescr: String, statusImage: UIImage, statusName: String){
        self.deliveryDescr.text = deliveryDescr
        self.deliveryNumber.text = deliveryNumber
        
        self.statusName.text = statusName
        self.statusName.textColor = UIColor.red
        
        self.statusImage.image = statusImage
        self.statusImage.tintColor = UIColor.red
    }
    
    func generateCell(_ delivery: Deliveries){
        
        self.deliveryDescr.text = "info"
        
        statusImage.image =  UIImage(systemName: "flag")!
        
        
        deliveryNumber.text = "Delivery #"+delivery.id
        
        if (delivery.inProcces == "False"){
            statusName.text = "NOT TAKEN"
            statusName.textColor = UIColor.red
            
            statusImage.tintColor = UIColor.red
        }else{
            statusName.text = "IN PROCESS"
            statusName.textColor = UIColor.green
            statusImage.tintColor = UIColor.green
        }
        
    }
}

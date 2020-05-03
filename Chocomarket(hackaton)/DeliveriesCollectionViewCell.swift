//
//  DeliveriesCollectionViewCell.swift
//  Chocomarket(hackaton)
//
//  Created by Khaled on 01.05.2020.
//  Copyright © 2020 Khaled. All rights reserved.
//

import UIKit

protocol DeliveryCellDelegate: class {
    func MoreButtonTapped(sender: DeliveriesCollectionViewCell)
}

class DeliveriesCollectionViewCell: UICollectionViewCell {
    var id: Int?
    weak var delegate: DeliveryCellDelegate?
    
    @IBOutlet weak var deliveryNumber: UILabel!
    @IBOutlet weak var deliveryDescr: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var statusName: UILabel!
    
    func update(deliveryNumber: String, deliveryDescr: String, statusImage: UIImage, statusName: String, color: UIColor){
        self.deliveryDescr.text = deliveryDescr
        self.deliveryNumber.text = deliveryNumber
        
        self.statusName.text = statusName
        self.statusName.textColor = color
        
        self.statusImage.image = statusImage
        self.statusImage.tintColor = color
    }
    
    @IBAction func moreButtonTapped(_ sender: Any) {
        delegate?.MoreButtonTapped(sender: self)
        print("tuta2")
        
    }
    
}

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
        self.deliveryNumber.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)

        self.dropShadow(scale: true)
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
extension UIView {

  // OUTPUT 1
  func dropShadow(scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 0.2
    layer.shadowOffset = CGSize(width: -5, height: 8)
    layer.shadowRadius = 3
    layer.cornerRadius = 10
    layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 0.2
  }

  // OUTPUT 2
  func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = color.cgColor
    layer.shadowOpacity = opacity
    layer.shadowOffset = offSet
    layer.shadowRadius = radius
    //layer.cornerRadius = 10
    layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }
}
